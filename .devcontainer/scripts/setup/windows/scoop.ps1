# https://scoop.sh/
Write-Host "Installing scoop..."
scoop install --global 7zip
scoop update --all --global
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
scoop install --global vcredist vcredist2022 gawk openssh vulkan openssl gitsign gh sed curl wget grep sed less touch sqlite gcc buf protobuf grpc-tools llvm bzip2 make cmake patch cacert file dos2unix shellcheck zlib age mkcert go python dotnet-nightly dotnet-sdk-preview dotnet-sdk dotnet-sdk-lts nvm chezmoi postgresql speedtest-cli speedtest jq gedit gimp vlc azure-cli aws fiddler
scoop update --all --global
Stop-Service -Force sshd
C:\ProgramData\scoop\apps\openssh\current\install-sshd.ps1
C:\ProgramData\scoop\apps\zlib\current\register.reg
# scoop update
scoop update
scoop update --all
scoop update --all --global
scoop status
