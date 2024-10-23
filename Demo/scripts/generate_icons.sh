#!/bin/bash

DIR='DesignSystem/components/Icon'

syncIconName() {
  local data="$1"
  local names="export type IconName ="

  # Extract icon names from JSON data
  local icons=$(echo "$data" | grep -o '"name": "[^"]*' | grep -o '[^"]*$')

  # Loop through icon names and construct names string
  for icon in $icons; do
    names+="\n  | '$icon'"
  done

  echo -e "$names"
}
# Download JSON file using curl
curl -sSL 'https://icons.libertycarz.com/hrm/selection.json' -o "$DIR/icomoon.json"

# Check if download was successful
if [ $? -ne 0 ]; then
  echo "Failed to download JSON file"
  exit 1
fi

# Remove existing IconNameType.ts
rm -f "$DIR/IconNameType.ts"

# Generate IconName type definition and append to IconNameType.ts
syncIconName "$(cat "$DIR/icomoon.json")" >> "$DIR/IconNameType.ts"

# Format IconNameType.ts using prettier
npx prettier --write "$DIR/IconNameType.ts"