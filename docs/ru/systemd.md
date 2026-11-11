# Запуск через systemd

GitSail может работать как systemd-служба в Ubuntu. Подготовьте конфигурацию хоста с удалённым Git-источником, каталогом состояния, учётными данными Git и age-ключом, если нужны секреты. Ограничьте права на закрытые файлы и каталоги.

Проверьте конфигурацию и GitOps-репозиторий:

```sh
gitsail config check --config /etc/gitsail/gitsail.yaml
gitsail validate --config /etc/gitsail/gitsail.yaml
gitsail plan --config /etc/gitsail/gitsail.yaml
```

Установите и проверьте службу:

```sh
gitsail install --config /etc/gitsail/gitsail.yaml
systemctl status gitsail
journalctl -u gitsail -f
```

Для обновления конфигурации GitSail перечитывает YAML во время работы; изменения установки, каталога состояния и Docker endpoint требуют перезапуска службы. Подробный рецепт — [установка на сервер](recipes/server.md); поля — в [справочнике конфигурации хоста](reference/host-configuration.md).
