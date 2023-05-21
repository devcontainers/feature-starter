try {
  scoop --version
} catch {
  Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}

scoop install sudo aria2 git
scoop config aria2-warning-enabled false
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
sudo scoop install vcredist git git-with-openssh openssh --global
sudo C:\ProgramData\scoop\apps\openssh\current\install-sshd.ps1
sudo scoop update --global --all
scoop install 7zip vscode pwsh pwsh-beta vulkan openssl curl grep sed less touch git-lfs gitsign git-credential-manager gh bzip2 make patch cacert speedtest-cli dos2unix shellcheck file wget zlib gcc python age mkcert chezmoi pester postgresql gedit gimp vlc nvm dotnet-nightly dotnet-sdk-preview dotnet-sdk dotnet-sdk-lts
git-credential-manager configure
git-credential-manager diagnose
"~\scoop\apps\7zip\current\install-context.reg"
"~\scoop\apps\git\current\install-context.reg"
"~\scoop\apps\git\current\install-file-associations.reg"
"~\scoop\apps\pwsh\current\install-file-context.reg"
"~\scoop\apps\vscode\current\install-context.reg"
"~\scoop\apps\vscode\current\install-associations.reg"
& "~\scoop\apps\vulkan\current\install-vk-layers.ps1"
nvm version
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
scoop status
