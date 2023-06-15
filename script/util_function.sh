#!/usr/bin/env bash

set -ue

function string_len() {
    echo -n "$*" | wc -m
}

function create_space_string() {
    local len
    local space_string
    len=$(((41-$(string_len "$*"))/2))
    space_string=""

    for i in `seq 1 $len`
    do
        space_string=$space_string" "
    done

    echo "${space_string}"
}

function print_info() {
    local space_string
    space_string=$(create_space_string "$*")
    echo ""
    echo -e "\e[1;94m#########################################\e[m"
    echo -e "${space_string}\e[1;94m$*\e[m"
    echo -e "\e[1;94m#########################################\e[m"
    echo ""
}

function print_success() {
    local space_string
    space_string=$(create_space_string "$*")
    echo ""
    echo -e "\e[1;92m#########################################\e[m"
    echo -e "${space_string}\e[1;92m$*\e[m"
    echo -e "\e[1;92m#########################################\e[m"
    echo ""
}

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
    ln -snf ${HOME}/.dotfiles/wezterm ${HOME}/.config/wezterm
}
