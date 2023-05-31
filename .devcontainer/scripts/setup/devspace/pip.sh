#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
# Setup pip
  python -m ensurepip --upgrade
  python -m pip install --upgrade pip
  pip install --use-pep517 pip-review
  pip install moreutils
  pip-review --auto
