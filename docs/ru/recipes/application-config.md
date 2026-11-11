# Добавить настройки приложения и метаданные `x-gitsail`

Храните конфигурацию в `apps/<namespace>/<app>/vars/`. Используйте не более трёх блоков верхнего уровня в указанном порядке; ненужные блоки опускайте:

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

Настройки приложения и секреты размещайте в `app`, параметры Docker Compose — в `compose`. Метаданные GitSail находятся в `compose.x-gitsail` и удаляются до передачи конфигурации в Compose. Поддерживается параметр `enabled`: значение `false` отключает приложение, отсутствие параметра или `true` включает его. Старый ключ верхнего уровня `enabled` пока также читается для совместимости при откате.

Словари из base и stage объединяются рекурсивно; списки и отдельные значения stage заменяют унаследованные. Значение `null` удаляет унаследованный ключ. См. [справочник полей приложения](../reference/app-configuration.md) и [справочник шаблонов](../reference/templates.md).
