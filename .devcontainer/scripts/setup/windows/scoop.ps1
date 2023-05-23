# Please make sure the winget is is installed
# Run this in Windows PowerShell as non-admin
# https://apps.microsoft.com/store/detail/app-installer/
# https://github.com/microsoft/winget-cli
# https://github.com/microsoft/winget-cli/issues/210
# https://scoop.sh/
try {
  scoop --version
} catch {
  Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}

scoop install sudo refreshenv
scoop update --all
sudo scoop install --global sudo refreshenv aria2
sudo scoop update --all --global
scoop config aria2-warning-enabled false
sudo "$PSScriptRoot/winget.ps1"
sudo "$PSScriptRoot/chocolatey.ps1"
refreshenv
scoop uninstall sudo refreshenv
sudo scoop install --global 7zip git git-with-openssh
sudo scoop update --all --global
refreshenv
scoop bucket add extras
scoop bucket add games
scoop bucket add nerd-fonts
scoop bucket add nirsoft
scoop bucket add sysinternals
scoop bucket add java
scoop bucket add nonportable
scoop bucket add php
scoop bucket add versions
scoop update
sudo scoop install --global vcredist vcredist2022 openssh vulkan openssl git-lfs gitsign gh curl wget grep sed less touch bzip2 make cmake patch cacert file dos2unix shellcheck zlib age mkcert gcc python dotnet-nightly dotnet-sdk-preview dotnet-sdk dotnet-sdk-lts nvm chezmoi postgresql speedtest-cli speedtest gedit gimp vlc
sudo scoop update --all --global
refreshenv
sudo Stop-Service -Force sshd
sudo C:\ProgramData\scoop\apps\openssh\current\install-sshd.ps1
refreshenv
sudo C:\ProgramData\scoop\apps\git\current\install-context.reg
sudo C:\ProgramData\scoop\apps\zlib\current\register.reg
scoop install pester
scoop update --all
try {
  dotnet tool install -g git-credential-manager
}
catch {
  dotnet tool upgrade -g git-credential-manager
}

git-credential-manager configure
git-credential-manager diagnose
nvm version
nvm on
refreshenv
# Install Node.js latest and lts
nvm install node
nvm install lts
# Update lts npm
nvm use lts
npm update -g npm
npm --version
npm version
# Update lts npm packages
npm i -g @devcontainers/cli
npm i -g dotenv-cli
npm i -g npm-check-updates
ncu -u
npm i
# Update latest npm
nvm use node
node --version
npm update -g npm
npm --version
npm version
# Update latest npm packages
npm i -g @devcontainers/cli
npm i -g dotenv-cli
npm i -g npm-check-updates
ncu -u
npm i
# scoop update
scoop update
scoop update --all
sudo scoop update --all --global
scoop status
try {
  gh auth status
} catch {
  gh auth login
}
Write-Output "Don't forget to set your git credentials:"
Write-Output 'git config --global user.name "Your Name"'
Write-Output 'git config --global user.email "youremail@yourdomain.com"'
sudo winget install --id Microsoft.PowerToys
