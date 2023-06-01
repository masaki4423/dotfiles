#!/usr/bin/env bash

set -ue

function main() {
    local current_dir
    current_dir=$(dirname "${BASH_SOURCE[0]}")
    source "${current_dir}/script/util_function.sh"

    detected_os=$(detect_os)
    "${current_dir}"/script/install_package.sh "${detected_os}"

    create_symbolic_link

    sudo chsh -s /bin/zsh
}

main
