#!/usr/bin/env bash
scriptPath="$1"
script="$2"

OUTPUT=""

while IFS= read -r LINE
do
  LINE=${LINE//\"/\\\"} # Escape double quotes
  LINE=${LINE//\$/\\\$} # Escape dollar signs
  OUTPUT+="$LINE && "
done < "$DEVCONTAINER_FEATURES_PROJECT_ROOT/$scriptPath/$script.sh"

# Remove trailing ' && '
OUTPUT=${OUTPUT::-4}

echo "$OUTPUT"
