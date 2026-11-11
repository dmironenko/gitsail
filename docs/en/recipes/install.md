# Install GitSail

## Install the command

On macOS or Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/dmironenko/gitsail/v1.0.0/install.sh | sh -s -- v1.0.0
```

The installer places `gitsail` in `~/.local/bin`. Add that directory to `PATH` if needed. Go is not required to run the installed command.

## Prepare a host configuration

Create `gitsail.yaml` outside the GitOps repository. For a local checkout:

```yaml
version: 1
installation: my-server
source:
  mode: local
  path: ./gitops
  branches:
    prod: main
    stage: dev
state_dir: ./gitsail-state
```

Paths are relative to `gitsail.yaml`; `state_dir` must be outside the source repository. `source.branches` maps environment names to Git branches. Check the file with `gitsail config check --config gitsail.yaml`.

Continue with [creating an app](create-an-app.md) or [installing on a server](server.md).
