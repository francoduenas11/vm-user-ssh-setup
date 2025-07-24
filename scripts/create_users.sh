#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Starting user creation script..."

USERS=("devops1" "devops2")

for u in "${USERS[@]}"; do
  if id "$u" &> /dev/null; then
    echo "[INFO] User $u already exists, skipping."
    continue
  fi

  echo "[INFO] Creating user $u..."
  adduser --disabled-password --gecos "" "$u"

  # Optionally set a default password (change or remove as needed)
  echo "$u:ChangeMe123!" | chpasswd

  # Set up SSH directory and authorized_keys
  mkdir -p /home/"$u"/.ssh
  chmod 700 /home/"$u"/.ssh
  cp ../keys/"$u".pub /home/"$u"/.ssh/authorized_keys
  chmod 600 /home/"$u"/.ssh/authorized_keys
  chown -R "$u":"$u" /home/"$u"/.ssh

  echo "[INFO] User $u created."
done

# Disable password authentication over SSH
sed -i 's/^#*PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config  
systemctl restart sshd

echo "[INFO] User creation complete and SSH hardened."
