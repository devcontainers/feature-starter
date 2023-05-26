#!/usr/bin/env bash
script="$1"

OUTPUT=""
while IFS= read -r LINE
do
  if [[ ! $LINE =~ ^# ]]; then # Skip comments
    LINE=${LINE//\"/\\\"} # Escape double quotes
    LINE=${LINE//\$/\\\$} # Escape dollar signs
    OUTPUT+="$LINE && "
  fi
done < "$DEVCONTAINER_SCRIPTS_ROOT/$script.sh"

# Remove trailing ' && '
OUTPUT=${OUTPUT::-4}

echo "$OUTPUT"
