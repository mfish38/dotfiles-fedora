#!/usr/bin/env fish

function install
    sudo dnf install -y $argv
end

function dotstow
    stow --adopt --dir=$HOME/dotfiles $argv
end

function etcstow
    sudo stow --adopt --dir=$HOME/dotfiles/etc --target=/etc/$argv $argv
end

function install_font
    set -l font_url $argv
    set -l font_dir ~/.local/share/fonts
    set -l font_zip (basename "$font_url")
    set -l font_path "$font_dir/$font_zip"

    mkdir -p "$font_dir"

    if not test -f "$font_path"
        echo "Downloading $font_zip..."
        curl -L "$font_url" -o "$font_path"
        and unzip -q "$font_path" -d "$font_dir"
        and fc-cache -f -v
    end
end

function install_vscode_extensions
    set -l installed (code --list-extensions)

    for extension in $argv
        if contains $extension $installed
            continue
        end

        echo "Installing $extension..."
        code --install-extension $extension
    end
end

# Dotfile Dependencies
install stow git

dotstow git

if not type -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; and fisher install jorgebucaran/fisher
end

# Firefox
set FIREFOX_PROFILE (find ~/.config/mozilla/firefox -maxdepth 1 -type d -name "*.default-release" | head -n 1)
stow --adopt --dir=$HOME/dotfiles --target=$FIREFOX_PROFILE firefox
etcstow firefox

# Discord
flatpak install -y flathub com.discordapp.Discord

# Node (via nvm fish plugin)
if not type -q nvm
    fisher install jorgebucaran/nvm.fish
end
nvm install 24

# Bun (installer is bash)
curl -fsSL https://bun.com/install | bash

# Fonts
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Gohu.zip

# # Docker
# pac docker docker-compose

# VSCode
if not test -f /etc/yum.repos.d/vscode.repo
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    and echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
end
install code

set extensions \
    vscodevim.vim \
    plievone.vscode-template-literal-editor \
    ms-azuretools.vscode-docker \
    talhabalaj.actual-font-changer \
    vue.volar \
    nuxtr.nuxt-vscode-extentions \
    streetsidesoftware.code-spell-checker \
    mechatroner.rainbow-csv \
    oderwat.indent-rainbow \
    esbenp.prettier-vscode \
    ionutvmi.path-autocomplete \
    ms-vsliveshare.vsliveshare \
    bradlc.vscode-tailwindcss \
    gruntfuggly.todo-tree \
    dbaeumer.vscode-eslint \
    bierner.github-markdown-preview \
    saeris.markdown-github-alerts \
    catppuccin.catppuccin-vsc-pack \
    murloccra4ler.leap \
    yoavbls.pretty-ts-errors \
    ms-vscode.vscode-speech \
    lucafalasco.matcha \
    lucafalasco.matchalk \
    github.vscode-github-actions \
    ryu1kn.partial-diff \
    bocovo.dbml-erd-visualizer

install_vscode_extensions $extensions

dotstow vscode
