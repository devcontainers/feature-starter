#!/usr/bin/env zsh
#shellcheck shell=bash
#shellcheck disable=SC2034
for j in {1..5}; do
    containerid=$(docker ps -q -f name="$DEVCONTAINER_FEATURES_PROJECT_ROOT-devspace")
    if [ -n "$containerid" ]; then
        docker rm -f "$containerid"
    fi
    volumes=$(docker volume ls -q -f name=name="${DEVCONTAINER_FEATURES_PROJECT_ROOT}_devcontainer")
    if [ -n "$volumes" ]; then
        echo "$volumes" | xargs docker volume rm -f
    fi

    docker container prune -f
    docker image prune -a -f
    docker network prune -f
    docker volume prune -f
done
