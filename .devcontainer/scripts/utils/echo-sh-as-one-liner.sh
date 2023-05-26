#!/usr/bin/env bash
script="$2"

OUTPUT=""

while IFS= read -r LINE
do
  LINE=${LINE//\"/\\\"} # Escape double quotes
  LINE=${LINE//\$/\\\$} # Escape dollar signs
  OUTPUT+="$LINE && "
done < "$DEVCONTAINER_FEATURES_PROJECT_ROOT/$script.sh"

# Remove trailing ' && '
OUTPUT=${OUTPUT::-4}

echo "$OUTPUT"
