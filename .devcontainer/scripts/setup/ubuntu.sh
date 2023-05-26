#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016
set -e
# Get current user
CURRENT_USER="$(whoami)"
# Update max open files
sudo sh -c "ulimit -n 1048576"
rcLine="$CURRENT_USER soft nofile 4096"
rcFile=/etc/security/limits.conf
sudo grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | sudo tee --append "$rcFile"
rcLine="$CURRENT_USER hard nofile 1048576"
sudo grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | sudo tee --append "$rcFile"
# Install apt-packages
sudo apt update
sudo apt install -y --fix-broken --fix-missing
sudo apt upgrade -y
sudo apt install -y git
packages="wslu,sudo,systemd,mawk,gawk,bash,zsh,file,sed,curl,wget,grep,bzip2,fonts-dejavu-core,gcc,g++,git,less,locales,openssl,openssh-client,make,cmake,netbase,patch,tzdata,uuid-runtime,apt-transport-https,ca-certificates,speedtest-cli,checkinstall,dos2unix,shellcheck,procps,software-properties-common,libnss3,libnss3-tools,build-essential,zlib1g-dev,bash-completion,age,powerline,fonts-powerline,jq,moreutils,gedit,gimp,nautilus,vlc,x11-apps"
sudo PACKAGES="$packages" UPDATEPACKAGES="true" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id rocker-org/devcontainer-features apt-packages install
age --version
age-keygen --version
# Install common-utils
# This messes up permissions for wsl user
# sudo USERNAME="$CURRENT_USER" INSTALLZSH="true" CONFIGUREZSHASDEFAULTSHELL="true" INSTALLOHMYZSH="true" USERUID="$CURRENT_UID" USERGID="$CURRENT_GID" NONFREEPACKAGES="true" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features common-utils install
# Test
zsh --version
sudo chsh "$CURRENT_USER" -s "$(which zsh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
# Install Brew
sudo USERNAME="$CURRENT_USER" BREWS="awk bash zsh file-formula gnu-sed curl wget grep bzip2 git git-lfs less openssl@1.1 openssl@3 openssh make cmake ca-certificates speedtest-cli dos2unix shellcheck procps nss zlib zlib-ng age jq moreutils gedit asdf sigstore/tap/gitsign gh mkcert chezmoi postgresql@15 azure-cli awscli" LINKS="postgresql@15" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -s homebrew install
alias sed=gsed
sed -i 's/^alias sed=.*$/alias sed=gsed/' "$HOME/.bashrc"
sed -i 's/^alias sed=.*$/alias sed=gsed/' "$HOME/.zshrc"
# Refresh environment profile
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
eval "$("/home/linuxbrew/.linuxbrew/bin/brew" shellenv)"# Test
brew --version
bash --version
zsh --version
mkcert --version
chezmoi --version
gitsign-credential-cache --version
psql --version
# Install dotnet
sudo rm -rf /usr/local/dotnet
sudo USERNAME="$CURRENT_USER" TOOLS="git-credential-manager" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -s dotnet install;
# Refresh environment profile
export PATH="/usr/local/dotnet/current:${PATH}"
export PATH="/home/acehack/.dotnet/tools:$PATH"
# Test
dotnet --version
# Install PowerShell
sudo VERSION="latest" MODULES="Set-PsEnv,Pester" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features powershell install
# Refresh environment profile
# Test
pwsh --version
# Install nvm
export NVM_DIR="/usr/local/share/nvm"
export PATH="$PATH:/usr/local/share/nvm/current/bin"
export NVM_SYMLINK_CURRENT="true"
sudo USERNAME="$CURRENT_USER" NODEGYPDEPENDENCIES="true" PACKAGES="@npmcli/fs,@devcontainers/cli,dotenv-cli" NVM_DIR="$NVM_DIR" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -s nvm install
# Refresh environment profile
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
# Test
nvm --version
node --version
docker --version
docker-compose --version
# Run post-build commands
sudo "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup/devspace post-build-sudo
"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup/devspace post-build-user
# Continue with devspace setup
"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup devspace
# Setup windows browser as default
alias xdg-open=wslview
export BROWSER=wslview
sed -i 's/^export BROWSER=.*$/export BROWSER=wslview/' "$HOME/.bashrc"
sed -i 's/^export BROWSER=.*$/export BROWSER=wslview/' "$HOME/.zshrc"
# Log into GitHub
if ! gh auth status; then gh auth login; fi
gh config set -h github.com git_protocol https
gh auth status
# Setup git credential manager
# TODO: Fix
# git-credential-manager configure
# git-credential-manager diagnose
# Setup environment
source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
echo "Don't forget to set your git credentials:"
echo 'git config --global user.name "Your Name"'
echo 'git config --global user.email "youremail@yourdomain.com"'
echo "WARNING: Please restart shell to get latest environment variables"
