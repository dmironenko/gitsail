# Add app settings and `x-gitsail` metadata

Keep app configuration in `apps/<namespace>/<app>/vars/`. Use only the top-level blocks below, in this order, omitting unused blocks:

```yaml
build:
  repository: https://github.com/example/service.git
  tag: v1.2.3

app:
  server:
    port: 8080

compose:
  x-gitsail:
    enabled: true
  services:
    server:
      image: example/service:1.2.3
```

Put application-native settings and secrets under `app`; put Docker Compose settings under `compose`. GitSail metadata lives under `compose.x-gitsail` and is removed before Compose receives the document. The supported option is `enabled`: `false` disables the app; omitted or `true` enables it. The old top-level `enabled` key remains accepted for rollback compatibility.

Maps merge recursively between base and stage; lists and scalar values are replaced by the stage value. `null` removes an inherited value. See the [application field reference](../reference/app-configuration.md) and [templates reference](../reference/templates.md).
