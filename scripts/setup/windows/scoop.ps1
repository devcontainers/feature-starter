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
sudo scoop install vcredist --global
sudo C:\ProgramData\scoop\apps\openssh\current\install-sshd.ps1
scoop install 7zip vscode pwsh pwsh-beta vulkan openssl curl grep sed less touch git-with-openssh git-lfs gitsign git-credential-manager gh bzip2 make patch cacert speedtest-cli dos2unix shellcheck file wget zlib gcc age mkcert chezmoi pester python postgresql gedit gimp vlc
scoop update --all
git config --global credential.helper manager
git-credential-manager configure
git-credential-manager diagnose
"~\scoop\apps\7zip\current\install-context.reg"
"~\scoop\apps\git\current\install-context.reg"
"~\scoop\apps\git\current\install-file-associations.reg"
"~\scoop\apps\pwsh\current\install-file-context.reg"
"~\scoop\apps\vscode\current\install-context.reg"
"~\scoop\apps\vscode\current\install-associations.reg"
& "~\scoop\apps\vulkan\current\install-vk-layers.ps1"
sudo scoop install openssh --global
sudo C:\ProgramData\scoop\apps\openssh\current\install-sshd.ps1
