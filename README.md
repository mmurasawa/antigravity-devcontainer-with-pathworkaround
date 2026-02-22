# Antigravity Devcontainer with Path Workaround

This repository contains a workaround for the Antigravity Remote Server path issue in devcontainers.

```
Editor sends: /home/node/.antigravity-server/bin/[HASH]/node
Actual path in container: /home/node/.antigravity-server/bin/[VERSION]-[HASH]/node (e.g., .../bin/1.16.5-1504c8.../node)
```
ref: https://discuss.ai.google.dev/t/root-cause-identified-temporary-workaround-to-users-and-google-developers-struggling-with-devcontainer-connection-issues/121549

## Workaround

The workaround is to use a script that monitors the bin directory and creates symlinks for versioned paths. The script is located at `.devcontainer/antigravity_path_watcher.sh`.

## Usage

1. Open the repository in Antigravity.
2. The script will automatically run and create the symlinks.
3. You can then use the Antigravity Remote Server as usual.

## How it Works

The `antigravity_path_watcher.sh` script handles binary path compatibility within the devcontainer:

1.  **Monitoring**: It continuously watches the `/home/vscode/.antigravity-server/bin` directory in the background.
2.  **Pattern Matching**: It identifies directories named with the `[VERSION]-[HASH]` pattern (e.g., `1.16.5-1504c8...`).
3.  **Symlink Creation**: It extracts the `[HASH]` part and creates a symbolic link from the hash to the full versioned directory.
4.  **Automatic Execution**: This ensures that tools looking for the server binary via its hash alone can find it successfully.

## Files

- `.devcontainer/Dockerfile`: Dockerfile for the devcontainer.
- `.devcontainer/antigravity_path_watcher.sh`: Script to create symlinks for versioned paths.
- `.devcontainer/devcontainer.json`: Devcontainer configuration.
- `.devcontainer/docker-compose.yml`: Docker Compose configuration.

## Reference

- https://discuss.ai.google.dev/t/root-cause-identified-temporary-workaround-to-users-and-google-developers-struggling-with-devcontainer-connection-issues/121549

