# CLI commands

All commands accept `--config PATH`; the default is `gitsail.yaml` in the current directory.

| Command | Use |
|---|---|
| `gitsail init PATH --branch BRANCH` | Create a starter host configuration and empty repository structure. |
| `gitsail config check` | Check host configuration syntax and fields. |
| `gitsail validate` | Validate app configuration and rendered Compose files. |
| `gitsail plan` | Show the changes GitSail plans to apply. |
| `gitsail apply` | Reconcile once and exit. Add `--wait` to retry until Compose reports readiness; `--timeout` sets the overall timeout (default `15m`). |
| `gitsail run` | Reconcile continuously, polling the configured source. |
| `gitsail template export compose --output FILE` | Export the built-in Compose template for customization. |
| `gitsail secrets encrypt` / `decrypt` | Encrypt or decrypt values using an age identity. |
| `gitsail install` | Install the Linux systemd service. |

Use `gitsail <command> --help` for command flags. Recipes: [install](../recipes/install.md), [secrets](../recipes/secrets.md), [server](../recipes/server.md).
