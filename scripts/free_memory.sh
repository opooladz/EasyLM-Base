#!/bin/bash

set -euo pipefail

echo "[*] Vacuuming journal logs (keeping 1 day)..."
sudo journalctl --vacuum-time=1d

echo "[*] Deleting rotated/compressed logs..."
sudo find /var/log -type f \( \
  -name "*.gz" -o -name "*.1" -o -name "*.old" -o -name "*.bak" -o \
  -name "*-????????" -o -name "*.log.[0-9]*" \
\) -print -delete

echo "[*] Truncating active log files..."
sudo find /var/log -type f -name "*.log" -exec truncate -s 0 {} \;

echo "[*] Vacuuming journal logs to 50MB cap..."
sudo journalctl --vacuum-size=50M

echo "[*] Setting Snap retention to 2 revisions..."
sudo snap set system refresh.retain=2

echo "[*] Removing old Snap revisions..."
snap list --all | grep disabled | while read -r name ver _; do
  echo "  - Removing $name revision $ver"
  sudo snap remove "$name" --revision="$ver"
done

echo "[✔] Cleanup complete."
