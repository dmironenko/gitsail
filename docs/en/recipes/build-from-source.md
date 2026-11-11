# Build an image from source

Add a `build` block and a Dockerfile template to the app directory:

```yaml
build:
  repository: https://github.com/example/service.git
  tag: v1.2.3
```

Place the template at `Dockerfile.tmpl`. Templates can read `.Vars.build`, for example `{{ .Vars.build.repository }}`. GitSail renders the Dockerfile, then builds it with an empty build context. Clone and compile source inside the Dockerfile. Git credentials configured under `source.auth` authenticate access to the GitOps repository only; they are not forwarded to source builds.

The build identity is repository, tag, and rendered Dockerfile. Change one of these inputs to request another build. Moving a branch or tag without changing its name does not trigger a rebuild. See the [app field reference](../reference/app-configuration.md).
