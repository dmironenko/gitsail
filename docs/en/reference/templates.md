# Templates and available fields

App config templates use Go template syntax. A file ending in `.tmpl` is rendered without the suffix; other files are copied unchanged. Templates can access:

| Field | Value |
|---|---|
| `.Vars` | Merged app variables, including `.Vars.build`, `.Vars.app`, and `.Vars.compose`. |
| `.Installation` | Installation name. |
| `.Env` | Current environment name. |
| `.Environments` | Configured environment names. |
| `.Namespace` | App namespace. |
| `.App` | App name. |
| `.Runtime.ProjectName` | Generated Compose project name. |
| `.Runtime.NetworkName` | Installation network name. |
| `.Runtime.Image` | Generated image name for a build. |

Helpers include `toYAML`, `toJSON`, `quote`, `quoteEnv`, `indent`, `get`, `default`, `dict`, `list`, `merge`, and `network`. The `network` helper plans an installation-managed network. Compose interpolation is disabled so `$` in rendered values stays literal.

The built-in Compose template can be exported with `gitsail template export compose --output compose.yaml.tmpl`. A custom template replaces the built-in template and must preserve required runtime fields. See [environment variables](../recipes/environment-variables.md).
