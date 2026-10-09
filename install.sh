#!/usr/bin/env bash
# Installs the script and adds the module to the Omarchy bar (right section).
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
dest="$HOME/.config/omarchy/bar/scripts"
cfg="$HOME/.config/omarchy/shell.json"

mkdir -p "$dest"
install -m 755 "$here/sysmon-status" "$dest/sysmon-status"
echo "Installed $dest/sysmon-status"

if jq -e '.bar.layout.right[]? | select(.id == "sysmon")' "$cfg" >/dev/null 2>&1; then
  echo "Module already present in $cfg"
  exit 0
fi

cp "$cfg" "$cfg.bak.sysmon"
tmp=$(mktemp)
jq '.bar.layout.right = ([{
      "id": "sysmon",
      "type": "command",
      "exec": "~/.config/omarchy/bar/scripts/sysmon-status",
      "interval": 2,
      "onClick": "omarchy-launch-or-focus-tui btop"
    }] + (.bar.layout.right // []))' "$cfg" > "$tmp"
mv "$tmp" "$cfg"
echo "Added module to $cfg (backup: $cfg.bak.sysmon)"
