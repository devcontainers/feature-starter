#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016
set -e
# Get current user
CURRENT_USER="$(whoami)"
CURRENT_UID="$(id -u)"
CURRENT_GID="$(id -g "$CURRENT_USER")"
# Install apt-packages
sudo apt install -y --fix-missing
packages="bzip2,sudo,fonts-dejavu-core,g++,git,less,libz-dev,locales,openssl,make,netbase,openssh-client,patch,tzdata,uuid-runtime,apt-transport-https,ca-certificates,speedtest-cli,checkinstall,dos2unix,shellcheck,file,wget,curl,zsh,bash,procps,software-properties-common,libnss3,libnss3-tools,build-essential,zlib1g-dev,gcc,bash-completion,age,postgresql-client,powerline,fonts-powerline,gedit,gimp,nautilus,vlc,x11-apps"
sudo PACKAGES="$packages" UPDATEPACKAGES="true" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id rocker-org/devcontainer-features apt-packages install
age --version
age-keygen --version
# Install common-utils
sudo USERNAME="$CURRENT_USER" INSTALLZSH="true" CONFIGUREZSHASDEFAULTSHELL="true" INSTALLOHMYZSH="true" USERUID="$CURRENT_UID" USERGID="$CURRENT_GID" NONFREEPACKAGES="true" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features common-utils install
zsh --version
# Install Brew
sudo USERNAME="$CURRENT_USER" BREWS="bash zsh mkcert chezmoi libpq sigstore/tap/gitsign" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" homebrew install
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew --version
mkcert --version
# Install dotnet
sudo rm -rf /usr/local/dotnet || true
sudo USERNAME="$CURRENT_USER" VERSION="latest" RUNTIMEONLY="false" INSTALLUSINGAPT="false" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features dotnet install
PATH="$PATH:/usr/local/dotnet/current"
dotnet --version
# Install PowerShell
sudo VERSION="latest" MODULES="Set-PsEnv,Pester" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features powershell install
pwsh --version
# Install Git
sudo VERSION="latest" PPA="true" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features git install
git --version
# Install Git LFS
sudo VERSION="latest" AUTOPULL="true" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features git-lfs install
git-lfs --version
# Install nvm
export NVM_DIR="/usr/local/share/nvm"
export NVM_SYMLINK_CURRENT="true"
export PATH="$PATH:/usr/local/share/nvm/current/bin"
sudo USERNAME="$CURRENT_USER" NODEGYPDEPENDENCIES="true" NVM_DIR="$NVM_DIR" NVM_SYMLINK_CURRENT="$NVM_SYMLINK_CURRENT" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" nvm install
nvm --version
node --version
# # Install GitHub CLI
# curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
# && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
# && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
# && sudo apt update \
# && sudo apt install gh -y
# gh --version
# # Install Docker Completions
# # sudo mkdir -p /etc/bash_completion.d
# # mkdir -p /usr/share/zsh/vendor-completions
# # sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
# # curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/docker -o /usr/share/zsh/vendor-completions/_docker
# docker --version
# docker-compose --version
# # Test age
# age --version
# age-keygen --version
# # Install mkcert and generate certs
# brew --version
# bash --version
# zsh --version
# mkcert --version
# chezmoi --version
# psql --version
# gitsign-credential-cache --version
# # Ensure new package sources and packages are available
# sudo apt update
# sudo apt upgrade -y
# sudo apt install -y gh git-lfs powershell dotnet-sdk-6.0 dotnet-sdk-7.0
# brew upgrade
# # Cleanup
# sudo apt autoclean -y
# sudo apt autoremove -y
# # Continue with devspace setup
# #"$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace.sh"
# # Log into GitHub
# if ! gh auth status; then gh auth login; fi
# gh config set -h github.com git_protocol https
