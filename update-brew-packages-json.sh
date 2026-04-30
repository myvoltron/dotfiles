#!/bin/bash
set -e

JSON_FILE=".chezmoidata/packages.json"

brew_output=$(brew bundle dump --file=-)

brew_list=$(echo "$brew_output" | awk '/^brew / {print $2}' | tr -d '"')
cask_list=$(echo "$brew_output" | awk '/^cask / {print $2}' | tr -d '"')

if [[ -f "$JSON_FILE" ]]; then
  all_json=$(cat "$JSON_FILE")
else
  all_json='{"packages": {"darwin": {"brews": [], "casks": []}}}'
fi

updated_json=$(echo "$all_json" | jq \
  --argjson brews "$(echo "$brew_list" | awk 'NF' | jq -R . | jq -s .)" \
  --argjson casks "$(echo "$cask_list" | awk 'NF' | jq -R . | jq -s .)" \
  '.packages.darwin.brews = $brews | .packages.darwin.casks = $casks')

echo "$updated_json" >"$JSON_FILE"

echo "✅ Updated $JSON_FILE (darwin packages completely synced with local state)"
