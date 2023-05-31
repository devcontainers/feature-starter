#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
# Setup pwsh modules
  pwsh_modules=('Pester' 'Set-PsEnv')
  pwsh_update='Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber; Update-Module; Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber -AllowPrerelease; Set-Alias -Name awk -Value gawk'
  # shellcheck disable=SC2016
  pwsh_install_module='Install-Module -Name $module -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber;'
  # shellcheck disable=SC2034
  install_modules() { local pwsh=$1; "$pwsh" -Command "$pwsh_update"; for module in "${pwsh_modules[@]}"; do $pwsh -Command "$(eval echo "$pwsh_install_module")"; done }
  # PowerShell Core (pwsh)
    if command -v pwsh > /dev/null; then install_modules "pwsh"; else echo "PowerShell Core is not installed"; fi
  # PowerShell Core Preview (pwsh-preview)
    if command -v pwsh-preview > /dev/null; then install_modules "pwsh-preview"; else echo "PowerShell Core Preview is not installed"; fi
