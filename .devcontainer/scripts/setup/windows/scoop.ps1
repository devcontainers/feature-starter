# https://scoop.sh/
Write-Host "Installing scoop..."
sudo scoop install --global 7zip git git-with-openssh
sudo scoop update --all --global
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
sudo scoop install --global vcredist vcredist2022 gawk openssh vulkan openssl git-lfs gitsign gh sed curl wget grep sed less touch gcc llvm bzip2 make cmake patch cacert file dos2unix shellcheck zlib age mkcert python dotnet-nightly dotnet-sdk-preview dotnet-sdk dotnet-sdk-lts nvm chezmoi postgresql speedtest-cli speedtest jq gedit gimp vlc azure-cli aws
sudo scoop update --all --global
sudo Stop-Service -Force sshd
sudo C:\ProgramData\scoop\apps\openssh\current\install-sshd.ps1
sudo C:\ProgramData\scoop\apps\git\current\install-context.reg
sudo C:\ProgramData\scoop\apps\zlib\current\register.reg
# scoop update
scoop update
scoop update --all
sudo scoop update --all --global
scoop status
