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
sudo PACKAGES="$packages" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id rocker-org/devcontainer-features apt-packages install
age --version
age-keygen --version
# Install common-utils
sudo INSTALLZSH=true CONFIGUREZSHASDEFAULTSHELL=true INSTALLOHMYZSH=true USERNAME="$CURRENT_USER" USERUID="$CURRENT_UID" USERGID="$CURRENT_GID" NONFREEPACKAGES=true "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features common-utils install
zsh --version
# Install Brew
sudo USERNAME="$CURRENT_USER" BREWS="bash zsh mkcert chezmoi libpq sigstore/tap/gitsign" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" homebrew install
# # Get Ubuntu version
# repo_version="$(lsb_release -r -s)"
# # Download Microsoft signing key and repository
# wget "https://packages.microsoft.com/config/ubuntu/$repo_version/packages-microsoft-prod.deb" -O /tmp/packages-microsoft-prod.deb
# # Install Microsoft signing key and repository
# sudo dpkg -i /tmp/packages-microsoft-prod.deb
# sudo apt-get update
# # Clean up
# rm -rf /tmp/packages-microsoft-prod.deb
# # Install Dotnet SDK versions
# sudo apt install dotnet-sdk-6.0 dotnet-sdk-7.0 -y
# wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh
# chmod +x /tmp/dotnet-install.sh
# /tmp/dotnet-install.sh --runtime "dotnet" --version "6.0.16"
# rm -rf /tmp/dotnet-install.sh
# dotnet --version
# # Install PowerShell
# sudo apt-get install -y powershell
# pwsh --version
# # Install Git LFS
# (. /etc/lsb-release && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo env os=ubuntu dist="${DISTRIB_CODENAME}" bash)
# sudo apt-get update
# sudo apt-get install git-lfs -y
# git-lfs --version
# # Install nvm
# cd /tmp
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
# # No need to restart after nvm install
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# nvm version
# # TODO: update ~/.bashrc the above script is only updating ~/.zshrc
# # Install Node.js
# nvm install --lts
# nvm install node
# nvm use --lts
# node --version
# # Update lts npm
# npm update -g npm
# npm --version
# npm version
# # Update npm packages
# npm i -g npm-check-updates && ncu -u && npm i
# nvm use node
# node --version
# # Update lts npm
# npm update -g npm
# npm --version
# npm version
# # Update npm packages
# npm i -g npm-check-updates && ncu -u && npm i
# cd ..
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
