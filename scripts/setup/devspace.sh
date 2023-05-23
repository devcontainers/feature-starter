#!/usr/bin/env zsh
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC1090
#shellcheck disable=SC2016
set -e
# Fix for nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
# Fix for git-credential-manager
export GCM_CREDENTIAL_STORE=cache
rcLine="export GCM_CREDENTIAL_STORE=cache"
rcFile=/etc/bash.bashrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | sudo tee -a "$rcFile"
rcFile=/etc/zsh/zshrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | sudo tee -a "$rcFile"
sudo rm -rf /usr/share/dotnet || false
sudo ln -s /usr/local/dotnet/6.0.408 /usr/share/dotnet
# Install Docker Completions
sudo rm -rf /etc/bash_completion.d/docker.sh || true
sudo mkdir -p /etc/bash_completion.d
sudo touch /etc/bash_completion.d/docker.sh
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
sudo rm -rf /usr/share/zsh/vendor-completions/_docker || true
sudo mkdir -p /usr/share/zsh/vendor-completions
sudo touch /usr/share/zsh/vendor-completions/_docker
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/docker -o /usr/share/zsh/vendor-completions/_docker
# Check all tools are installed
docker --version
docker-compose --version
bash --version
zsh --version
pwsh --version
git --version
git-lfs --version
git-credential-manager --version
gitsign --version
gitsign-credential-cache --version
gh --version
dotnet --version
nvm version
node --version
npm --version
npm version
brew --version
age --version
age-keygen --version
mkcert --version
chezmoi --version
psql --version
devcontainer --version
# Setup git credential manager
git-credential-manager configure
git-credential-manager diagnose
# Make container a Root CA and trust it
mkcert -install
dotnet dev-certs https --trust
# Adding GH .ssh known hosts
mkdir -p ~/.ssh/
touch ~/.ssh/known_hosts
bash -c eval "$(ssh-keyscan github.com >> ~/.ssh/known_hosts)"
# # Install Chrome
# sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
# sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
# sudo rm -rf /tmp/google-chrome-stable_current_amd64.deb
# # Install Edge
# sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg
# sudo install -o root -g root -m 644 /tmp/microsoft.gpg /usr/share/keyrings/
# sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
# sudo rm /tmp/microsoft.gpg
# sudo apt update
# sudo apt install microsoft-edge-dev
# sudo apt update
# sudo apt upgrade --fix-broken -y
