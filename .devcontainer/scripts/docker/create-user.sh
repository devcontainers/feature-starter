#!/usr/bin/env bash

USERNAME="$1"
USER_UID="$2"
USER_GID="$3"

if id "$USERNAME"; then 
    echo "User $USERNAME already exists"
else
    echo "Creating user $USERNAME"
    groupadd --gid $USER_GID $USERNAME
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
    apt-get update
    apt-get install -y sudo
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME
    chmod 0440 /etc/sudoers.d/$USERNAME
fi
