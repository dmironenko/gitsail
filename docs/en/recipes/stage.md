# Create a stage or personal environment

Map an environment name to a branch in the host configuration:

```yaml
source:
  branches:
    prod: main
    stage: dev
```

For each app, `prod` reads only `vars/base.yaml`. Every other environment reads `base.yaml` and then `stage.yaml`. Add `apps/<namespace>/<app>/vars/stage.yaml` to enable that app in stage; an empty `{}` is enough. If the file is absent, the app is disabled in non-production environments.

To add a personal environment, map a name such as `alice` to a branch. Its service names receive `-alice`. Each environment has separate Compose projects and volumes; data is not copied from production. Removing an environment mapping removes its containers but retains volumes and images.

Only the name `prod` has special behavior. Branch names are freely chosen. See [host configuration](../reference/host-configuration.md).
