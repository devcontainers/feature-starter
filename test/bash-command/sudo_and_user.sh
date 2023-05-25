#!/usr/bin/env bash
#shellcheck disable=SC2016
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib


check "echo \$HELLO" [ "$(source /etc/environment && echo "$HELLO")" == "5" ]

user=vscode
sudoers_dir="/etc/sudoers.d"
sudoers_file="$sudoers_dir/$user"
line="$user ALL=(ALL:ALL) NOPASSWD: ALL"
mkdir -p $sudoers_dir
sudo touch $sudoers_file
grep -qF "$line" $sudoers_file || echo "$line" >> $sudoers_file
chmod 0440 $sudoers_file
check "echo \$CURRENT_USER" [ "$(su "$user" -c 'source $HOME/.bashrc && echo $CURRENT_USER')" == "$user" ]


reportResults
