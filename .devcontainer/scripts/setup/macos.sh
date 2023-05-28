#!/usr/bin/env zsh
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016,SC2155
set -e
# Setup Developer Command Line tools
if ! git --version; then sudo xcode-select --install; fi
# Setup ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" || true
rcFile="$HOME/.zshrc"
rcLine='source ~/powerlevel10k/powerlevel10k.zsh-theme'
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Setup environment
rcLine="source \"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run\" setup environment"
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Setup Homebrew
rcLine='eval "$(/usr/local/bin/brew shellenv)"'
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval "$(/usr/local/bin/brew shellenv)"
brew update
# Install Homebrew packages
brew install sevenzip p7zip awk bash zsh powershell oh-my-posh file-formula gnu-sed coreutils curl wget grep bzip2 git git-lfs less sqlite gcc llvm openssl@1.1 openssl@3 nghttp2 openssh make cmake go python@3.11 ca-certificates speedtest-cli dos2unix shellcheck nss mono-libgdiplus zlib zlib-ng age jq moreutils gedit asdf sigstore/tap/gitsign gh mkcert chezmoi postgresql@15 azure-cli awscli
# Setup post hombrew packages
brew link --force --overwrite postgresql@15
source /usr/local/opt/asdf/libexec/asdf.sh
rcLine='source /usr/local/opt/asdf/libexec/asdf.sh'
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Install Microsoft SQL tap and brews
brew tap --force-auto-update microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew tap --repair
brew update
HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql18 mssql-tools18
# Install Homebrew casks
brew install --cask iterm2
brew update --cask
# Run Homebrew doctor to check for errors
brew upgrade
brew upgrade --cask
brew cleanup
brew doctor
# Setup nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm version
# Install Node.js latest and lts
nvm install node
nvm install lts
# Update lts npm
nvm use lts
npm update -g npm
npm --version
npm version
# Update lts npm packages
npm i -g @npmcli/fs
npm i -g @devcontainers/cli
npm i -g dotenv-cli
npm i -g typescript
npm i -g npm-check-updates
ncu -u
npm i
# Update latest npm
nvm use node
node --version
npm update -g npm
npm --version
npm version
# Update latest npm packages
npm i -g @npmcli/fs
npm i -g @devcontainers/cli
npm i -g dotenv-cli
npm i -g typescript
npm i -g npm-check-updates
ncu -u
npm i
# Setup dotnet
asdf plugin-add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git || true
asdf plugin update --all
lts="$(asdf list all dotnet-core 6)"
current="$(asdf list all dotnet-core 7)"
preview="$(asdf list all dotnet-core 8)"
asdf install dotnet-core "$lts"
asdf install dotnet-core "$current"
asdf install dotnet-core "$preview"
asdf global dotnet-core "$lts"
asdf reshim
asdf info
PATH="$HOME/.dotnet/tools:$PATH"
source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh"
rcLine='PATH="$HOME/.dotnet/tools:$PATH"'
rcLine='source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh"'
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
dotnet --version
dotnet --info
# Log into GitHub
if ! gh auth status; then gh auth login; fi
gh config set -h github.com git_protocol https
gh auth status
# Setup environment
source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
echo "WARNING: Please restart shell to get latest environment variables"
