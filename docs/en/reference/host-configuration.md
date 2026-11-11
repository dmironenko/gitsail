# Host configuration fields

The host YAML is passed with `--config` (default: `gitsail.yaml`). Paths are resolved relative to that YAML file.

| Field | Purpose |
|---|---|
| `version` | Required schema version: `1`. |
| `installation` | Required Docker-compatible installation name; isolates this GitSail installation. |
| `source.mode` | `local` or `remote`. |
| `source.path` | Local Git repository path; required in local mode. |
| `source.url` | Remote Git URL; required in remote mode. |
| `source.branches` | Required map of environment names to branch names. `prod` is the only special environment name. |
| `source.poll_interval` | Polling frequency; default `1m`. |
| `source.auth.type` | `https`, `ssh`, or omitted/`none`. Used for remote Git source only. |
| `source.auth.token_file` | HTTPS token file. |
| `source.auth.key_file` | SSH private key file. |
| `source.auth.known_hosts_file` | SSH known-hosts file. |
| `state_dir` | Required private state directory. In local mode it must be outside the source repository. |
| `age_key_file` | Optional age identity used to decrypt `ENC[...]` values. Keep it outside Git. |
| `docker.host` / `docker.context` | Optional Docker endpoint or context; set at most one. |
| `reconcile.parallelism` | Concurrent app reconciliation; default `4`. |
| `reconcile.git_timeout` | Git operation timeout; default `30s`. |
| `reconcile.deploy_timeout` | Deployment timeout; default `5m`. |

Durations accept Go duration syntax, such as `2s`, `1m`, and `5m`. Example: [install GitSail](../recipes/install.md).
