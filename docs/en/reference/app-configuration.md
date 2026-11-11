# Application fields

An app lives at `apps/<namespace>/<name>`. Its required `vars/base.yaml` has up to three top-level blocks in order: `build`, `app`, `compose`.

| Field | Meaning |
|---|---|
| `build.repository` | Source repository cloned by the app's Dockerfile template. |
| `build.tag` | Git tag, branch, or commit selected by that Dockerfile. |
| `app` | Free-form application-native settings and secrets, available to config templates as `.Vars.app`. |
| `app.env` | Optional map of environment variable names to values. Render it to a file referenced by Compose `env_file`; it is not injected automatically. |
| `compose` | Docker Compose project and service configuration. Use the official [Compose Specification](https://compose-spec.github.io/compose-spec/). |
| `compose.x-gitsail.enabled` | GitSail extension: `false` disables the app; otherwise enabled. Stripped before Compose validation. |

Additional keys under `build` and `app` are application-defined. Keys under `compose` follow the Compose Specification, which defines the complete set of Compose fields. Use `gitsail validate` to check a repository. GitSail applies default restart, shared network, and log rotation settings unless the Compose file explicitly configures the corresponding service options.

At runtime, `prod` reads only `base.yaml`; other environments merge `base.yaml` then `stage.yaml`. Maps merge recursively, lists/scalars replace, and `null` removes inherited keys.
