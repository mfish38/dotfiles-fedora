#!/usr/bin/env bash
set -euo pipefail

# Location of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo dnf install -y fish

exec fish "$SCRIPT_DIR/install.fish" "$@"
