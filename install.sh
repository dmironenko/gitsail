#!/bin/sh
set -eu

fail() {
  printf 'gitsail: %s\n' "$*" >&2
  exit 1
}

main() {
  case "${1:-}" in
    -h|--help) printf 'usage: install.sh VERSION [DIRECTORY]\ndefault directory: ~/.local/bin\n'; return ;;
  esac
  [ "$#" -ge 1 ] && [ "$#" -le 2 ] || fail 'usage: install.sh VERSION [DIRECTORY]'

  version=$1
  case "$version" in
    *[!a-zA-Z0-9.+-]*) fail 'invalid version; use a release tag such as v1.0.0' ;;
  esac
  case "$version" in
    v[0-9]*) ;;
    *) fail 'invalid version; use a release tag such as v1.0.0' ;;
  esac

  case "$(uname -s)" in
    Linux) os=linux ;;
    Darwin) os=darwin ;;
    *) fail 'supported systems: Linux and macOS' ;;
  esac
  case "$(uname -m)" in
    x86_64|amd64) arch=amd64 ;;
    aarch64|arm64) arch=arm64 ;;
    *) fail 'supported architectures: amd64 and arm64' ;;
  esac

  install_dir=${2:-"${HOME:?HOME is not set}/.local/bin"}
  case "$install_dir" in
    /*) ;;
    *) install_dir="$(pwd)/$install_dir" ;;
  esac
  target=$install_dir/gitsail
  [ ! -d "$target" ] || fail "$target is a directory"

  work_dir=$(mktemp -d)
  staged=''
  trap 'rm -rf "$work_dir"; [ -z "$staged" ] || rm -f "$staged"' EXIT
  trap 'exit 130' INT
  trap 'exit 143' TERM

  archive=gitsail_${version}_${os}_${arch}.tar.gz
  url=https://github.com/dmironenko/gitsail/releases/download/$version
  printf 'Downloading GitSail %s for %s/%s\n' "$version" "$os" "$arch"
  curl -fsSL --proto '=https' "$url/$archive" -o "$work_dir/$archive"
  curl -fsSL --proto '=https' "$url/checksums.txt" -o "$work_dir/checksums.txt"

  awk -v file="./$archive" '$2 == file {print}' "$work_dir/checksums.txt" > "$work_dir/checksum"
  [ -s "$work_dir/checksum" ] || fail "no checksum found for $archive"
  if command -v sha256sum >/dev/null 2>&1; then
    (cd "$work_dir" && sha256sum -c checksum)
  elif command -v shasum >/dev/null 2>&1; then
    (cd "$work_dir" && shasum -a 256 -c checksum)
  else
    fail 'install sha256sum or shasum to verify the download'
  fi

  tar -xzf "$work_dir/$archive" -C "$work_dir" gitsail
  [ -f "$work_dir/gitsail" ] && [ ! -L "$work_dir/gitsail" ] || fail 'archive must contain a regular gitsail binary'
  [ "$("$work_dir/gitsail" --version)" = "gitsail version $version" ] || fail 'downloaded binary reports an unexpected version'

  mkdir -p "$install_dir"
  staged=$(mktemp "$install_dir/.gitsail.XXXXXX")
  install -m 755 "$work_dir/gitsail" "$staged"
  mv -f "$staged" "$target"

  printf 'Installed GitSail %s to %s\n' "$version" "$target"
  case ":$PATH:" in
    *":$install_dir:"*) ;;
    *) printf 'Add %s to your PATH to run gitsail by name.\n' "$install_dir" ;;
  esac
}

main "$@"
