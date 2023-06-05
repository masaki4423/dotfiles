#!/usr/bin/env bash

set -ue

function install_linux_package() {
    if [ "$1" == 'debian' ]; then
        sudo DEBIAN_FRONTEND=noninteractive \
            apt-get install -y \
            zsh git curl wget fontconfig jq python3 python3-pip gcc unzip exa peco fzf
    fi
}

function install_font() {
    # Install Source Code Pro Nerd Fonts
    local font_version
    font_version=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r '.tag_name')

    sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/${font_version}/SourceCodePro.zip -P /usr/local/share/fonts/
    sudo unzip /usr/local/share/fonts/SourceCodePro.zip -d /usr/local/share/fonts/
    sudo rm /usr/local/share/fonts/SourceCodePro.zip

    sudo fc-cache /usr/local/share/fonts/
}

function install_zinit() {
    curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh | bash
}

function install_rustup() {
    curl https://sh.rustup.rs -sSf | sh -s -- -y
}

function install_zig() {
    local ZIG_VERSION
    ZIG_VERSION=$(curl https://ziglang.org/download/index.json | jq -r 'keys_unsorted[1]')

    mkdir -p ${HOME}/.zig/
    wget https://ziglang.org/download/${ZIG_VERSION}/zig-linux-$(arch)-${ZIG_VERSION}.tar.xz -P ${HOME}/
    tar xf ${HOME}/zig-linux-$(arch)-${ZIG_VERSION}.tar.xz -C ${HOME}/.zig/ --strip-components 1
    rm ${HOME}/zig-linux-$(arch)-${ZIG_VERSION}.tar.xz
}

function install_neovim() {
    mkdir -p ${HOME}/.local/
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -P ${HOME}/
    tar xzvf ${HOME}/nvim-linux64.tar.gz -C ${HOME}/.local/ --strip-components 1
    rm ${HOME}/nvim-linux64.tar.gz
}

function install_oh_my_posh() {
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ${HOME}/.local/bin
}

function main() {
    local current_dir
    current_dir=$(dirname "${BASH_SOURCE[0]}")

    while [ $# -gt 0 ]; do
        case ${1} in
            debian)
                install_linux_package ${1}
                shift
                ;;
            *)
                echo "error: invalid arguments '${1}'"
                exit 1
                ;;
        esac
    done

    install_font
    install_zinit
    install_rustup
    install_zig
    install_neovim
    install_oh_my_posh
}

main "$@"
