# Установить GitSail на сервер

В Ubuntu установите бинарный файл GitSail и создайте конфигурацию хоста вне checkout GitOps-репозитория. Используйте `source.mode: remote` с URL репозитория и подходящими правами только на чтение. Для HTTPS задайте `source.auth.type: https` и `token_file`; для SSH — `source.auth.type: ssh`, `key_file` и `known_hosts_file`.

Укажите закрытый каталог `state_dir` с абсолютным путём и `age_key_file`, если в репозитории есть зашифрованные значения. Перед запуском проверьте конфигурацию и репозиторий:

```sh
gitsail config check --config /etc/gitsail/gitsail.yaml
gitsail validate --config /etc/gitsail/gitsail.yaml
gitsail plan --config /etc/gitsail/gitsail.yaml
```

Установите systemd-службу командой `gitsail install --config /etc/gitsail/gitsail.yaml`, затем проверьте её через `systemctl status gitsail` и `journalctl -u gitsail -f`. Подробности — в [руководстве по systemd](../systemd.md) и [справочнике конфигурации хоста](../reference/host-configuration.md).
