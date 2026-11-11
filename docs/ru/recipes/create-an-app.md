# Создать приложение

Создайте каталог в GitOps-репозитории:

```text
apps/<namespace>/<app>/vars/base.yaml
```

Например, `apps/shop/web/vars/base.yaml`:

```yaml
compose:
  services:
    web:
      image: nginx:alpine
      ports:
        - 8080:80
```

Закоммитьте файл. GitSail находит приложения в `apps`; файл `base.yaml` обязателен. Каталог приложения — отдельный Compose-проект. Блок `compose` соответствует Docker Compose Specification; настройки приложения и секреты хранятся в `app`, параметры GitSail — в `compose.x-gitsail`.

Запустите `gitsail validate --config gitsail.yaml`, изучите план через `gitsail plan --config gitsail.yaml`, затем примените его командой `gitsail apply --config gitsail.yaml --wait`. См. [справочник полей приложения](../reference/app-configuration.md).
