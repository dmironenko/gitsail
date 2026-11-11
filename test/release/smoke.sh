#!/bin/sh
set -eu

gitsail=${1:?usage: smoke.sh GITSAIL_BINARY WORK_DIRECTORY}
root=${2:?usage: smoke.sh GITSAIL_BINARY WORK_DIRECTORY}

fail() {
  printf 'release smoke: %s\n' "$*" >&2
  exit 1
}

[ -x "$gitsail" ] || fail "GitSail binary is not executable: $gitsail"
command -v git >/dev/null 2>&1 || fail 'git is required'
command -v docker >/dev/null 2>&1 || fail 'docker is required'
docker info >/dev/null || fail 'Docker daemon is unavailable'

[ ! -e "$root" ] || fail "smoke work directory already exists: $root"
mkdir -p "$root/repository"
repo="$root/repository"
config="$root/host.yaml"

git -C "$repo" init --quiet --initial-branch=main
"$gitsail" init "$repo" --branch main --installation release-smoke --config "$config"
"$gitsail" config check --config "$config"
"$gitsail" template export compose --output "$root/compose.yaml.tmpl"
[ -s "$root/compose.yaml.tmpl" ] || fail 'Compose template export is empty'

key_file=internal/app/gitsail/adapters/gitops/internal/vars/testdata/age-key.txt
printf 'release-smoke-secret' | "$gitsail" secrets encrypt --key-file "$key_file" > "$root/encrypted.txt"
"$gitsail" secrets decrypt --key-file "$key_file" < "$root/encrypted.txt" > "$root/decrypted.txt"
[ "$(cat "$root/decrypted.txt")" = release-smoke-secret ] || fail 'secret encrypt/decrypt round trip failed'

mkdir -p "$repo/apps/smoke/worker/vars"
cat > "$repo/apps/smoke/worker/vars/base.yaml" <<'EOF'
compose:
  services:
    worker:
      image: alpine:3.22
      command: ["sh", "-c", "sleep 300"]
EOF

git -C "$repo" add .
git -C "$repo" -c user.name='GitSail CI' -c user.email='ci@example.invalid' commit --quiet -m 'smoke: add worker'

"$gitsail" validate --config "$config"
"$gitsail" plan --config "$config"
"$gitsail" apply --config "$config" --wait --timeout 3m

# Exercise the continuous agent and make sure it shuts down cleanly on SIGINT.
"$gitsail" run --config "$config" >"$root/run.log" 2>&1 &
run_pid=$!
sleep 5
if ! kill -0 "$run_pid" 2>/dev/null; then
  cat "$root/run.log" >&2
  fail 'gitsail run exited before the smoke check'
fi
kill -INT "$run_pid"
if ! wait "$run_pid"; then
  cat "$root/run.log" >&2
  fail 'gitsail run did not stop cleanly'
fi

# Make sure apply can reconcile a config-only change and remove the service.
cat > "$repo/apps/smoke/worker/vars/base.yaml" <<'EOF'
compose:
  x-gitsail:
    enabled: false
  services:
    worker:
      image: alpine:3.22
      command: ["sh", "-c", "sleep 300"]
EOF
git -C "$repo" add .
git -C "$repo" -c user.name='GitSail CI' -c user.email='ci@example.invalid' commit --quiet -m 'smoke: disable worker'
"$gitsail" apply --config "$config" --wait --timeout 3m

printf 'Release CLI smoke test passed\n'
