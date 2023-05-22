projectRoot=$PSScriptRoot | Split-Path -Parent | Split-Path -Parent |  Split-Path -Parent
Set-Variable -o allexport
source "$projectRoot/.env"
Set-Variable +o allexport
export PSHELL="pwsh"
export DEVCONTAINER_FEATURES_PROJECT_ROOT="$projectRoot"
export DEVCONTAINER_FEATURES_SOURCE_ROOT="$DEVCONTAINER_FEATURES_PROJECT_ROOT/src"
export DEVCONTAINER_SCRIPTS_ROOT="$DEVCONTAINER_FEATURES_PROJECT_ROOT/scripts"
