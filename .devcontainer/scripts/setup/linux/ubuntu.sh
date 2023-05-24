#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016
set -e
# Get current user
CURRENT_USER="$(whoami)"
# Update submodules
pushd "$DEVCONTAINER_FEATURES_PROJECT_ROOT"
git submodule sync --recursive
git submodule update --init --recursive
git submodule foreach --recursive git checkout main
git submodule foreach --recursive git pull
popd
# Install apt-packages
sudo apt update
sudo apt install -y --fix-broken --fix-missing
sudo apt upgrade -y
packages="sudo,bash,zsh,file,curl,wget,grep,bzip2,fonts-dejavu-core,gcc,g++,git,less,locales,openssl,openssh-client,make,cmake,netbase,patch,tzdata,uuid-runtime,apt-transport-https,ca-certificates,speedtest-cli,checkinstall,dos2unix,shellcheck,procps,software-properties-common,libnss3,libnss3-tools,build-essential,zlib1g-dev,bash-completion,age,powerline,fonts-powerline,gedit,gimp,nautilus,vlc,x11-apps"
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
sudo USERNAME="$CURRENT_USER" BREWS="bash zsh file-formula curl wget grep bzip2 git git-lfs less openssl@1.1 openssl@3 openssh make cmake ca-certificates speedtest-cli dos2unix shellcheck procps nss zlib zlib-ng age gedit asdf sigstore/tap/gitsign gh mkcert chezmoi postgresql@15" LINKS="postgresql@15" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -s homebrew install
# Refresh environment profile
reset
source ~/.bashrc
# Test
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
reset
source ~/.bashrc
# Test
dotnet --version
# Install PowerShell
sudo VERSION="latest" MODULES="Set-PsEnv,Pester" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features powershell install
# Refresh environment profile
reset
source ~/.bashrc
# Test
pwsh --version
# Install nvm
export NVM_DIR="/usr/local/share/nvm"
export PATH="$PATH:/usr/local/share/nvm/current/bin"
export NVM_SYMLINK_CURRENT="true"
sudo USERNAME="$CURRENT_USER" NODEGYPDEPENDENCIES="true" PACKAGES="@npmcli/fs,@devcontainers/cli,dotenv-cli" NVM_DIR="$NVM_DIR" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -s nvm install
# Refresh environment profile
reset
source ~/.bashrc
# Test
nvm --version
node --version
docker --version
docker-compose --version
# Run post-build command
sudo COMMAND="$DEVCONTAINER_POST_BUILD_COMMAND" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers-contrib/features bash-command install
# Refresh environment profile
reset
source ~/.bashrc
# Continue with devspace setup
"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup devspace
# Refresh environment profile
reset
source ~/.bashrc
# Log into GitHub
if ! gh auth status; then gh auth login; fi
gh config set -h github.com git_protocol https
gh auth status
# Setup git credential manager
# TODO: Fix
# git-credential-manager configure
# git-credential-manager diagnose
# Refresh environment profile
reset
source ~/.bashrc
# Setup environment
"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
echo "Don't forget to set your git credentials:"
echo 'git config --global user.name "Your Name"'
echo 'git config --global user.email "youremail@yourdomain.com"'
echo "WARNING: Please restart shell to get latest environment variables"
