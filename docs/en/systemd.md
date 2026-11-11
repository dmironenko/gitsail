# Run GitSail with systemd

GitSail can run as a systemd service on Ubuntu. Prepare a host configuration with a remote Git source, state directory, Git credentials, and an age key if encrypted values are used. Restrict access to private files and directories.

Check the configuration and repository:

```sh
gitsail config check --config /etc/gitsail/gitsail.yaml
gitsail validate --config /etc/gitsail/gitsail.yaml
gitsail plan --config /etc/gitsail/gitsail.yaml
```

Install and inspect the service:

```sh
gitsail install --config /etc/gitsail/gitsail.yaml
systemctl status gitsail
journalctl -u gitsail -f
```

GitSail reloads host YAML while running. Changes to installation, state directory, or Docker endpoint require restarting the service. See the [server recipe](recipes/server.md) and [host field reference](reference/host-configuration.md).
