#!/usr/bin/env bash

assert_default_shell_is_zsh() {
  bash -c "if ! [[ \"$SHELL\" =~ \"/zsh\"$ ]]; then exit 1; fi"
}
