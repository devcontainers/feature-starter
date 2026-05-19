#!/bin/bash
set -e

source dev-container-features-test-lib

check "tofu is installed" tofu --version
check "tfswitch is installed" command -v tfswitch
check "terragrunt is installed" terragrunt --version

# We also check if our config script was added
check "terragrunt tfpath configured" grep -q "export TERRAGRUNT_TFPATH=tofu" /etc/profile.d/terragrunt-opentofu.sh
check "tfswitch alias configured" grep -q "alias tfswitch='tfswitch --product opentofu'" /etc/profile.d/tfswitch-opentofu.sh

reportResults
