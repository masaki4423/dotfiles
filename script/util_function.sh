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
    if [ -L ${HOME}/.zshrc ]; then
        unlink ${HOME}/.zshrc
    elif [ -f ${HOME}/.zshrc ]; then
        rm ${HOME}/.zshrc
    fi

    if [ -L ${HOME}/.config/nvim ]; then
        unlink ${HOME}/.config/nvim
    elif [ -f ${HOME}/.config/nvim ]; then
        rm -r ${HOME}/.config/nvim
    fi

    if [ -L ${HOME}/.wezterm.lua ]; then
        unlink ${HOME}/.wezterm.lua
    elif [ -f ${HOME}/.wezterm.lua ]; then
        rm ${HOME}/.wezterm.lua
    fi

    ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
    ln -s ${HOME}/.dotfiles/nvim ${HOME}/.config/nvim
    ln -s ${HOME}/.dotfiles/.wezterm.lua ${HOME}/.wezterm.lua
}
