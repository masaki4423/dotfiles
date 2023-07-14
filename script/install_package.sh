#!/usr/bin/env bash

set -ue

current_dir=$(dirname "${BASH_SOURCE[0]}")
source "${current_dir}/util_function.sh"

function install_linux_package() {
    if [ "$1" == 'debian' ]; then
        sudo DEBIAN_FRONTEND=noninteractive \
            apt-get install -y \
                zsh \
                git \
                lsb-release \
                libwayland-dev \
                libx11-xcb-dev \
                libxcb-ewmh-dev \
                libxcb-icccm4-dev \
                libxcb-image0-dev \
                libxcb-keysyms1-dev \
                libxcb-randr0-dev \
                libxcb-render0-dev \
                libxcb-xkb-dev \
                libxkbcommon-dev \
                libxkbcommon-x11-dev \
                curl \
                wget \
                cmake \
                gettext \
                fontconfig \
                jq \
                python3 \
                python3-pip \
                gcc \
                unzip \
                exa \
                peco \
                fzf
    fi
}

function install_homebrew() {
    if ! type "brew" > /dev/null 2>&1; then
        print_info "Install Homebrew"
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | NONINTERACTIVE=1 bash
        print_success "Installation Successed"
    else
        print_info "Already Installed Homebrew"
    fi
}

function install_homebrew_package() {
    local brewfile_path

    print_info "Install Homebrew Package"
    brewfile_path=$(dirname "${BASH_SOURCE[0]}")/../Brewfile
    brew bundle --file=${brewfile_path}
    print_success "Installation Successed"
}

function install_font() {
    # Install Source Code Pro Nerd Fonts
    print_info "Install Source Code Pro Nerd Fonts"

    local font_version
    font_version=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r '.tag_name')

    sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/${font_version}/SourceCodePro.zip -P /usr/local/share/fonts/
    sudo unzip -o /usr/local/share/fonts/SourceCodePro.zip -d /usr/local/share/fonts/
    sudo rm /usr/local/share/fonts/SourceCodePro.zip

    sudo fc-cache /usr/local/share/fonts/

    print_success "Installation Successed"
}

function install_zinit() {
    print_info " Install Zinit"

    curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh | bash

    print_success "Installation Successed"
}

function install_rustup() {
    print_info " Install Rust"

    curl https://sh.rustup.rs -sSf | sh -s -- -y

    print_success "Installation Successed"
}

function install_zig() {
    print_info "Install Zig"

    local ZIG_VERSION
    ZIG_VERSION=$(curl https://ziglang.org/download/index.json | jq -r 'keys_unsorted[1]')

    mkdir -p ${HOME}/.zig/
    wget https://ziglang.org/download/${ZIG_VERSION}/zig-linux-$(arch)-${ZIG_VERSION}.tar.xz -P ${HOME}/
    tar xf ${HOME}/zig-linux-$(arch)-${ZIG_VERSION}.tar.xz -C ${HOME}/.zig/ --strip-components 1
    rm ${HOME}/zig-linux-$(arch)-${ZIG_VERSION}.tar.xz

    print_success "Installation Successed"
}

function install_neovim() {
    print_info "Install NeoVim"

    mkdir -p ${HOME}/.local/

    if [ $(arch) == "x86_64" ];then
        wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -P ${HOME}/
        tar xzvf ${HOME}/nvim-linux64.tar.gz -C ${HOME}/.local/ --strip-components 1
        rm ${HOME}/nvim-linux64.tar.gz
    else
        mkdir -p ${HOME}/.local/bin/
        git clone -b stable --depth=1 https://github.com/neovim/neovim ${HOME}/neovim
        cd ${HOME}/neovim && make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=${HOME}/.local/"
        make install
        cd -
        rm -rf ${HOME}/neovim/
    fi

    print_success "Installation Successed"
}

function install_oh_my_posh() {
    print_info "Install Oh My Posh"

    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ${HOME}/.local/bin

    print_success "Installation Successed"
}

function install_wezterm() {
    print_info "Install WezTerm"

    local tag_name
    local distributor_id
    local release_version
    tag_name=$(curl -s https://api.github.com/repos/wez/wezterm/releases/latest | jq -r '.tag_name')
    distributor_id=$(lsb_release -is 2>/dev/null || sh -c "source /etc/os-release && echo \$NAME")
    release_version=$(lsb_release -rs 2>/dev/null || sh -c "source /etc/os-release && echo \$VERSION_ID")

    if [ $(arch) == "x86_64" ]; then
        wget https://github.com/wez/wezterm/releases/download/${tag_name}/wezterm-${tag_name}.${distributor_id}${release_version}.deb -P ${HOME}/
        sudo dpkg -i ${HOME}/wezterm-${tag_name}.${distributor_id}${release_version}.deb 
        rm ${HOME}/wezterm-${tag_name}.${distributor_id}${release_version}.deb 
    else
        git clone -b ${tag_name} --depth=1 --recursive https://github.com/wez/wezterm.git ${HOME}/wezterm
        cd ${HOME}/wezterm
        set +eu
        ./get-deps
        set -eu
        ${HOME}/.cargo/bin/cargo build --all --release
        make_wezterm_package
        sudo dpkg -i wezterm-${tag_name}.${distributor_id}${release_version}.deb
        cd -
        rm -rf ${HOME}/wezterm/
    fi

    print_success "Installation Successed"
}

function make_wezterm_package() {
    # This source code is mostly copied from wezterm's ci/deploy.sh.

    TAG_NAME=${TAG_NAME:-$(git -c "core.abbrev=8" show -s "--format=%cd-%h" "--date=format:%Y%m%d-%H%M%S")}

    distro=$(lsb_release -is 2>/dev/null || sh -c "source /etc/os-release && echo \$NAME")
    distver=$(lsb_release -rs 2>/dev/null || sh -c "source /etc/os-release && echo \$VERSION_ID")

    rm -rf pkg
    mkdir -p pkg/debian/usr/bin pkg/debian/DEBIAN pkg/debian/usr/share/{applications,wezterm}
    cat > pkg/debian/control <<EOF
Package: wezterm
Version: ${TAG_NAME#nightly-}
Architecture: $(dpkg-architecture -q DEB_BUILD_ARCH_CPU)
Maintainer: Wez Furlong <wez@wezfurlong.org>
Section: utils
Priority: optional
Homepage: https://wezfurlong.org/wezterm/
Description: Wez's Terminal Emulator.
 wezterm is a terminal emulator with support for modern features
 such as fonts with ligatures, hyperlinks, tabs and multiple
 windows.
Provides: x-terminal-emulator
Source: https://wezfurlong.org/wezterm/
EOF

        cat > pkg/debian/postinst <<EOF
#!/bin/sh
set -e
if [ "\$1" = "configure" ] ; then
        update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/open-wezterm-here 20
fi
EOF

        cat > pkg/debian/prerm <<EOF
#!/bin/sh
set -e
if [ "\$1" = "remove" ]; then
	update-alternatives --remove x-terminal-emulator /usr/bin/open-wezterm-here
fi
EOF

    install -Dsm755 -t pkg/debian/usr/bin target/release/wezterm-mux-server
    install -Dsm755 -t pkg/debian/usr/bin target/release/wezterm-gui
    install -Dsm755 -t pkg/debian/usr/bin target/release/wezterm
    install -Dm755 -t pkg/debian/usr/bin assets/open-wezterm-here
    install -Dsm755 -t pkg/debian/usr/bin target/release/strip-ansi-escapes

    deps=$(cd pkg && dpkg-shlibdeps -O -e debian/usr/bin/*)
    mv pkg/debian/postinst pkg/debian/DEBIAN/postinst
    chmod 0755 pkg/debian/DEBIAN/postinst
    mv pkg/debian/prerm pkg/debian/DEBIAN/prerm
    chmod 0755 pkg/debian/DEBIAN/prerm
    mv pkg/debian/control pkg/debian/DEBIAN/control
    sed -i '/^Source:/d' pkg/debian/DEBIAN/control  # The `Source:` field needs to be valid in a binary package
    echo $deps | sed -e 's/shlibs:Depends=/Depends: /' >> pkg/debian/DEBIAN/control
    cat pkg/debian/DEBIAN/control

    install -Dm644 assets/icon/terminal.png pkg/debian/usr/share/icons/hicolor/128x128/apps/org.wezfurlong.wezterm.png
    install -Dm644 assets/wezterm.desktop pkg/debian/usr/share/applications/org.wezfurlong.wezterm.desktop
    install -Dm644 assets/wezterm.appdata.xml pkg/debian/usr/share/metainfo/org.wezfurlong.wezterm.appdata.xml
    install -Dm644 assets/wezterm-nautilus.py pkg/debian/usr/share/nautilus-python/extensions/wezterm-nautilus.py
    install -Dm644 assets/shell-completion/bash pkg/debian/usr/share/bash-completion/completions/wezterm
    install -Dm644 assets/shell-completion/zsh pkg/debian/usr/share/zsh/functions/Completion/Unix/_wezterm
    install -Dm644 assets/shell-integration/* -t pkg/debian/etc/profile.d
    debname=wezterm-$TAG_NAME.$distro$distver
    fakeroot dpkg-deb --build pkg/debian $debname.deb

    mv pkg/debian pkg/wezterm
    tar cJf $debname.tar.xz -C pkg wezterm
    rm -rf pkg
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
            darwin)
                install_homebrew
                install_homebrew_package
                install_zinit
                return
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
    install_wezterm
}

main "$@"
