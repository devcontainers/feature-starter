#!/usr/bin/env bash
if ! gh auth status; then gh auth login; fi
gh config set -h github.com git_protocol https
gh auth status
