"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup ubuntu
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
echo "Don't forget to run 'gh auth login'"
echo "WARNING: Please restart shell to get latest environment variables"
