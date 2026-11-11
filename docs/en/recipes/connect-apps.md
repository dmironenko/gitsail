# Connect one app to another

Apps in one installation share a network by default. Set the destination app's Compose service name as the hostname. For example, an `api` service can call `http://catalog:8080` when the other app has a service named `catalog`.

Service names must be unique across namespaces. In `prod`, GitSail keeps the declared service name. In every other environment, it adds `-<environment>`; a service called `catalog` becomes `catalog-stage` in `stage`. GitSail rewrites Compose service references within the same app, but URLs in app configuration must account for environment names themselves.

Apps reconcile independently. For cross-app dependencies, make the client retry until the target is ready. `depends_on` only orders services inside one app. Explicit `networks` or `network_mode` settings replace the default network behavior. See [stage environments](stage.md).
