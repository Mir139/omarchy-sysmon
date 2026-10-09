#!/usr/bin/env bash
set -euo pipefail
cfg="$HOME/.config/omarchy/shell.json"
tmp=$(mktemp)
jq '.bar.layout |= with_entries(.value |= map(select(.id != "sysmon")))' "$cfg" > "$tmp"
mv "$tmp" "$cfg"
rm -f "$HOME/.config/omarchy/bar/scripts/sysmon-status"
echo "Removed."
