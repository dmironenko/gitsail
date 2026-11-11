# Disable an app or environment

To disable an app outside production, remove its `vars/stage.yaml`; missing stage configuration disables that app in every non-prod environment. To disable it everywhere, set `compose.x-gitsail.enabled: false` in its vars or remove the app directory from the source.

GitSail removes the app's containers. It retains volumes and images, so data remains available if the app is enabled again. Removing an environment mapping also removes that environment's containers and retains its volumes and images. GitSail never automatically deletes volumes or images.
