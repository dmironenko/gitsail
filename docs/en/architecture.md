# How GitSail works

GitSail reads committed Git snapshots, combines app vars for each environment, renders config templates, builds requested images, and reconciles each app as a Compose project. `prod` uses `base.yaml`; other environments use `base.yaml` and `stage.yaml`. All apps in one installation share a network by default. This page is optional background; start with the [task index](../../README.en.md).
