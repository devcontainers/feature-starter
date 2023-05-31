#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source /etc/bash.bashrc
# Install docker completions
  rm -rf /etc/bash_completion.d/docker.sh || true
  mkdir -p /etc/bash_completion.d
  touch /etc/bash_completion.d/docker.sh
  curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
  rm -rf /usr/share/zsh/vendor-completions/_docker || true
  mkdir -p /usr/share/zsh/vendor-completions
  touch /usr/share/zsh/vendor-completions/_docker
  curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/docker -o /usr/share/zsh/vendor-completions/_docker
