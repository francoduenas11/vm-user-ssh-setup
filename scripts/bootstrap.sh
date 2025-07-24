#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/francoduenas11/vm-user-ssh-setup.git"
CLONE_DIR="$HOME/vm-setup"
SCRIPTS_DIR="$CLONE_DIR/scripts"

echo "[STEP] Update & install git"
sudo apt update  
sudo apt install -y git

if [ -d "$CLONE_DIR/.git" ]; then
  echo "[STEP] Repo exists, pulling latest changes"
  git -C "$CLONE_DIR" pull
else
  echo "[STEP] Cloning fresh repo"
  git clone "$REPO_URL" "$CLONE_DIR"
fi

echo "[STEP] Ensuring script executables"
chmod +x "$SCRIPTS_DIR"/*.sh

echo "[STEP] Running user-creation"
sudo bash "$SCRIPTS_DIR/create_users.sh"

echo "[INFO] Bootstrap completed successfully!"
