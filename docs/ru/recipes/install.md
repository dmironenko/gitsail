# Установить GitSail

## Установить команду

Для macOS или Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/dmironenko/gitsail/v1.0.0/install.sh | sh -s -- v1.0.0
```

Установщик помещает `gitsail` в `~/.local/bin`. При необходимости добавьте каталог в `PATH`. Go для запуска установленной команды не нужен.

## Подготовить конфигурацию хоста

Создайте `gitsail.yaml` вне GitOps-репозитория. Пример для локального checkout:

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

Пути отсчитываются от `gitsail.yaml`; `state_dir` должен находиться вне репозитория. `source.branches` сопоставляет имена окружений с Git-ветками. Проверьте файл командой `gitsail config check --config gitsail.yaml`.

Дальше: [создать приложение](create-an-app.md) или [установить GitSail на сервер](server.md).
