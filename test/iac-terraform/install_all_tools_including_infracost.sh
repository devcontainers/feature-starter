#!/bin/bash
set -e

source dev-container-features-test-lib

# Core tools
check "terraform is installed" terraform --version
check "tfswitch is installed" command -v tfswitch
check "terragrunt is installed" terragrunt --version

# Mandatory analysis tools
check "tflint is installed" tflint --version
check "terraform-docs is installed" terraform-docs --version
check "terrascan is installed" terrascan version
check "trivy is installed" trivy --version
check "checkov is installed" checkov --version
check "pre-commit is installed" pre-commit --version

# Optional tools
check "infracost is installed" infracost --version

reportResults
