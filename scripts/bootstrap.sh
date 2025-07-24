#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/francoduenas11/vm-user-ssh-setup.git"
CLONE_DIR="$HOME/vm-setup"

echo "[STEP] Update & install git"
sudo apt update
sudo apt install -y git

if [ -d "$CLONE_DIR/.git" ]; then
  echo "[STEP] Fetching and hard-resetting repo"
  git -C "$CLONE_DIR" fetch --all
  git -C "$CLONE_DIR" reset --hard origin/main
else
  echo "[STEP] Cloning fresh repo"
  git clone "$REPO_URL" "$CLONE_DIR"
fi

# Copy host scripts over
echo "[STEP] Overriding scripts with host /vagrant/scripts"
cp -r /vagrant/scripts/* "$CLONE_DIR/scripts/"
chmod +x "$CLONE_DIR/scripts/"*.sh

echo "[STEP] Running user-creation"
sudo bash "$CLONE_DIR/scripts/create_users.sh"
echo "[INFO] Bootstrap complete!"
