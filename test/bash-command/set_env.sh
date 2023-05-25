#!/bin/bash

set -e

source dev-container-features-test-lib


check "echo $HELLO" [ "$(source /etc/environment && echo $HELLO)" == "5" ]


reportResults
