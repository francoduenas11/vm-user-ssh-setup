#!/usr/bin/env bash
# Create new users and configure SSH

set -e

# Example users
USERS=("devops1" "devops2")

for u in "${USERS[@]}"; do
  sudo adduser --disabled-password --gecos "" "$u"
  echo "$u:ChangeMe123!" | sudo chpasswd
  sudo mkdir -p /home/$u/.ssh
  sudo chmod 700 /home/$u/.ssh
  # Copy your public key (assumes you’ve added it to the repo)
  sudo cp ../keys/$u.pub /home/$u/.ssh/authorized_keys
  sudo chmod 600 /home/$u/.ssh/authorized_keys
  sudo chown -R $u:$u /home/$u/.ssh
done

# Harden SSHD
sudo sed -i 's/^#*PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "Users created and SSH hardened."
