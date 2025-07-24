#!/usr/bin/env bash
# Run this on a fresh VM

# Update & install essentials
sudo apt update && sudo apt install -y git

# Clone your repo
git clone https://github.com/francoduenas11/vm-user-ssh-setup.git ~/vm-setup
cd ~/vm-setup/scripts

# Run user setup
./create_users.sh
