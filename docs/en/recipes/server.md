# Install GitSail on a server

On Ubuntu, install the GitSail binary and create a dedicated host configuration outside the GitOps checkout. Use `source.mode: remote` with the repository URL and a suitable read-only credential. For HTTPS, use `source.auth.type: https` and `token_file`; for SSH, use `source.auth.type: ssh`, `key_file`, and `known_hosts_file`.

Set an absolute `state_dir` with restricted permissions and an `age_key_file` when the repository contains encrypted values. Check the host config and repository before starting:

```sh
gitsail config check --config /etc/gitsail/gitsail.yaml
gitsail validate --config /etc/gitsail/gitsail.yaml
gitsail plan --config /etc/gitsail/gitsail.yaml
```

Install the systemd service with `gitsail install --config /etc/gitsail/gitsail.yaml`, then inspect it with `systemctl status gitsail` and `journalctl -u gitsail -f`. See the full [systemd guide](../systemd.md) and [host configuration reference](../reference/host-configuration.md).
