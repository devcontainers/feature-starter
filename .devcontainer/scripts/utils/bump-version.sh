#!/usr/bin/env bash

# Get a list of all changed features
CHANGED_FEATURES=$(git diff --name-only HEAD~1 HEAD | awk -F'/' '{print $2}' | uniq)

for feature in $CHANGED_FEATURES; do
    # Ensure the directory exists
    if [[ -d "./src/$feature" ]]; then
        # Bump the version in the feature's JSON file
        json_file="src/$feature/devcontainer-feature.json"
        jq '.version = (.version | split(".") | map(tonumber) | .[2] += 1 | join("."))' "$json_file" | sponge "$json_file"
    else
        echo -e "No directory found for $feature"
    fi
done
