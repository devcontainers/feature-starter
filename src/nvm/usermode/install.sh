#!/usr/bin/env bash
#shellcheck source=/dev/null
set -e
umask 0002
# Do not update profile - we'll do this manually
export PROFILE=/dev/null
curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash 
export NVM_DIR="${NVM_DIR}"
[ -s "\$NVM_DIR/nvm.sh" ] && . "\$NVM_DIR/nvm.sh"
[ -s "\$NVM_DIR/bash_completion" ] && . "\$NVM_DIR/bash_completion"
