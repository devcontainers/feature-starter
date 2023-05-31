#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
# Make Edge the default browser if installed
  browser='/usr/bin/microsoft-edge-stable'
  cmds=("alias xdg-open=$browser" "export BROWSER=$browser")
  seds=("s:^alias xdg-open=.*$:alias xdg-open=$browser:" "s:^export BROWSER=.*$:export BROWSER=$browser:")
  files=("$HOME/.bashrc" "$HOME/.zshrc")
  # shellcheck disable=SC2068
  for i in ${!cmds[@]}; do
    cmd="${cmds[$i]}"
    sed="${seds[$i]}"
    eval "$cmd"
    for file in "${files[@]}"; do
      sed -i "$sed" "$file"
      grep -qF "$cmd" "$file" || echo "$cmd" >> "$file"
    done
  done
