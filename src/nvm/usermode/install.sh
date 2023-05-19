#!/usr/bin/env bash
#shellcheck source=/dev/null
set -e
umask 0002
# Do not update profile - we'll do this manually
export PROFILE=/dev/null
curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash 
source "${NVM_DIR}/nvm.sh"
