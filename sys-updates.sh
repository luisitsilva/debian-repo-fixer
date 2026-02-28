#!/bin/bash

set -e

echo "Fixing Debian 13 (Trixie) APT repositories..."

# Must run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root: sudo $0"
  exit 1
fi

# Remove cdrom entries if present
if [ -f /etc/apt/sources.list ]; then
  sed -i '/^deb cdrom:/s/^/#/' /etc/apt/sources.list
fi

# Remove old Debian sources files (optional but clean)
rm -f /etc/apt/sources.list.d/debian.sources
rm -f /etc/apt/sources.list.d/debian.list

# Create official Debian 13 repositories (deb822 format)
cat <<EOF > /etc/apt/sources.list.d/debian.sources
Types: deb deb-src
URIs: https://deb.debian.org/debian
Suites: trixie
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb deb-src
URIs: https://deb.debian.org/debian
Suites: trixie-updates
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb deb-src
URIs: https://security.debian.org/debian-security
Suites: trixie-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb deb-src
URIs: https://deb.debian.org/debian
Suites: trixie-backports
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF

echo "Repositories configured successfully."
echo "Running apt update..."

apt update

echo "Done."
