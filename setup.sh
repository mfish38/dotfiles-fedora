#!/usr/bin/env bash
set -euo pipefail

sudo dnf install -y git
git clone https://github.com/mfish38/dotfiles-fedora.git ~/dotfiles
bash ~/dotfiles/install.sh
