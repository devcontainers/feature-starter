# https://scoop.sh/
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
Install-Module -Name PsEnv
# scoop update
scoop update
scoop update --all
sudo scoop update --all --global
scoop status
