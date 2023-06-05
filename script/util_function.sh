#!/usr/bin/env bash

function detect_os() {
    if [ "$(uname)" == 'Darwin' ]; then
        echo 'darwin'
        return
    elif [ "$(uname)" == 'Linux' ]; then
        if [ -f /etc/debian_version ]; then
            echo 'debian'
            return
        fi
    else
        return
    fi
}

function create_symbolic_link() {
    mkdir -p ${HOME}/.config

    ln -sf ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
    ln -snf ${HOME}/.dotfiles/nvim ${HOME}/.config/nvim
    ln -sf ${HOME}/.dotfiles/.wezterm.lua ${HOME}/.wezterm.lua
}
