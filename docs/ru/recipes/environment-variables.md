# Передать переменные окружения в контейнер

Запишите значения приложения в `app.env` файла `vars/base.yaml` (или `stage.yaml`):

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

Создайте `configs/app.env.tmpl`, чтобы GitSail сформировал файл, указанный в `env_file`:

```gotemplate
{{- range $name, $value := .Vars.app.env }}
{{ $name }}={{ quoteEnv $value }}
{{- end }}
```

Используйте имена переменных, ожидаемые образом. `app.env` — данные для шаблонов; GitSail не передаёт их контейнерам автоматически. `quoteEnv` экранирует значения для формата env-файла. Секреты шифруйте по инструкции [Хранить и использовать секреты](secrets.md).
