#!/bin/bash

# Antigravity Remote Server binary path workaround
# This script monitors the bin directory and creates symlinks for versioned paths.
# by https://discuss.ai.google.dev/t/root-cause-identified-temporary-workaround-to-users-and-google-developers-struggling-with-devcontainer-connection-issues/121549

BIN_DIR="/home/vscode/.antigravity-server/bin"

echo "Starting Antigravity path watcher for $BIN_DIR..."

# Ensure the parent directory exists
mkdir -p "$BIN_DIR"

# Background monitoring loop
(
  while true; do
    if [ -d "$BIN_DIR" ]; then
      for dir_path in "$BIN_DIR"/*; do
        if [ -d "$dir_path" ]; then
          dir_name=$(basename "$dir_path")
          # Match [VERSION]-[HASH] pattern (e.g., 1.16.5-1504c8...)
          # Extract the hash part after the first dash
          if [[ "$dir_name" =~ ^[0-9]+\.[0-9]+\.[0-9]+-(.+)$ ]]; then
            HASH="${BASH_REMATCH[1]}"
            if [ ! -L "$BIN_DIR/$HASH" ] && [ ! -d "$BIN_DIR/$HASH" ]; then
              ln -s "$dir_name" "$BIN_DIR/$HASH"
              echo "Workaround: Created symlink $BIN_DIR/$HASH -> $dir_name"
            fi
          fi
        fi
      done
    fi
    sleep 5
  done
) &

echo "Antigravity path watcher is running in background."
