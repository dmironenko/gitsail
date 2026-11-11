# Create an app

Create this directory in the GitOps repository:

```text
apps/<namespace>/<app>/vars/base.yaml
```

For example, `apps/shop/web/vars/base.yaml`:

```yaml
compose:
  services:
    web:
      image: nginx:alpine
      ports:
        - 8080:80
```

Commit the file. GitSail discovers app directories under `apps`; `base.yaml` is required. An app directory is one independent Compose project. `compose` follows the Docker Compose specification; app settings and secrets belong in `app`, and GitSail settings belong in `compose.x-gitsail`.

Run `gitsail validate --config gitsail.yaml`, inspect `gitsail plan --config gitsail.yaml`, then apply with `gitsail apply --config gitsail.yaml --wait`. See the [application field reference](../reference/app-configuration.md).
