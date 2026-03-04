#!/usr/bin/env bash
set -euo pipefail

if [ -d ~/dotfiles ]; then
    echo "WARNING: ~/dotfiles already exists. Aborting." >&2
    exit 1
fi

sudo dnf install -y git
git clone https://github.com/mfish38/dotfiles-fedora.git ~/dotfiles
bash ~/dotfiles/install.sh
