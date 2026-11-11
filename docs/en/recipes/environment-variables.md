# Pass environment variables to a container

Put application values under `app.env` in `vars/base.yaml` (or `stage.yaml`):

```yaml
app:
  env:
    LOG_LEVEL: info
    DATABASE_URL: ENC[...]

compose:
  services:
    web:
      env_file: ./configs/app.env
```

Create `configs/app.env.tmpl` so GitSail writes the values into the file referenced by `env_file`:

```gotemplate
{{- range $name, $value := .Vars.app.env }}
{{ $name }}={{ quoteEnv $value }}
{{- end }}
```

Use the exact variable names expected by the image. `app.env` is data for templates; GitSail does not inject it into containers automatically. `quoteEnv` escapes values for env-file syntax. Encrypt credentials as described in [Store and use secrets](secrets.md).
