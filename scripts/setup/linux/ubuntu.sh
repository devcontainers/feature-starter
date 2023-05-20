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
sudo USERNAME="$CURRENT_USER" BREWS="bash zsh git git-lfs sigstore/tap/gitsign gh mkcert chezmoi libpq" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" homebrew install
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew --version
bash --version
zsh --version
mkcert --version
chezmoi --version
psql --version
gitsign-credential-cache --version
# Install dotnet
sudo rm -rf /usr/local/dotnet || true
sudo USERNAME="$CURRENT_USER" TOOLS="git-credential-manager" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" dotnet install
PATH="$PATH:/usr/local/dotnet/current"
dotnet --version
# Install PowerShell
sudo VERSION="latest" MODULES="Set-PsEnv,Pester" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features powershell install
pwsh --version
# Install nvm
export NVM_DIR="/usr/local/share/nvm"
export PATH="$PATH:/usr/local/share/nvm/current/bin"
export NVM_SYMLINK_CURRENT="true"
sudo USERNAME="$CURRENT_USER" NODEGYPDEPENDENCIES="true" PACKAGES="@devcontainers/cli,dotenv-cli" NVM_DIR="$NVM_DIR" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" nvm install
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
nvm --version
node --version
docker --version
docker-compose --version
# Cleanup
sudo apt autoclean -y
sudo apt autoremove -y
# Continue with devspace setup
"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -s setup devspace
# Log into GitHub
if ! gh auth status; then gh auth login; fi
gh config set -h github.com git_protocol https
