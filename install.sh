#!/bin/bash

DOTPATH=~/.dotfiles

if type "git" > /dev/null 2>&1; then
    git clone --recursive "https://github.com/masaki4423/dotfiles.git" "$DOTPATH"

elif type "curl" > /dev/null 2>&1 || type "wget" > /dev/null 2>&1; then
    tarball="https://github.com/masaki4423/dotfiles/archive/master.tar.gz"

    if type "curl" > /dev/null 2>&1; then
        curl -L "$tarball"

    elif type "wget" > /dev/null 2>&1; then
        wget -O - "$tarball"
    
    fi | tar zxv

    mv -f dotfiles-master "$DOTPATH"

else
    echo "curl or wget required" 
    exit 1
fi

# Install Homebrew, Homebrew Cask and iTerm2 for macOS
if [ "$(uname)" == 'Darwin' ]; then
    if ! type "brew" > /dev/null 2>&1; then
        echo "Install Homebrew"
        xcode-select --install
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        brew install cask
        brew cask install iterm2
    else
        echo "already installed Homebrew"
    fi
else
    echo "OS is not macOS. Homebrew will not be installed."
fi

# Update Package manager
if [ "$(uname)" == 'Darwin' ]; then
    brew upgrade; brew cask upgrade
elif [ "$(uname)" == 'Linux' ]; then
    if type "apt" > /dev/null 2>&1; then
        sudo apt update -y ; sudo apt upgrade -y
        echo 'deb https://dl.bintray.com/dryzig/zig-ubuntu focal main' | sudo tee -a /etc/apt/sources.list
        sudo apt update -y
    fi
fi

echo "Updated Package manager!"

# Install git
if ! type "git" > /dev/null 2>&1; then
    if type "brew" > /dev/null 2>&1; then
        brew install git
    elif type "apt" > /dev/null 2>&1; then
        sudo apt install -y git
    fi
else
    echo "already installed git"
fi

# Install C compiler
if ! type "cc" > /dev/null 2>&1; then
    if type "apt" > /dev/null 2>&1; then
        sudo apt install -y gcc
    fi
else
    echo "already installed gcc"
fi

# Install zsh
if ! type "/bin/zsh" > /dev/null 2>&1; then
    if [ "$(uname)" == 'Darwin' ]; then
        brew install zsh
    elif type "apt" > /dev/null 2>&1; then
        sudo apt install -y zsh
    fi
else
    echo "already installed zsh"
fi

# Install zsh-autosuggestions
if [ ! -d "$HOME/.zsh/zsh-autosuggestions/" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
else
    echo "already installed zsh-autosuggestions"
fi

# Install zinit
if [ ! -e "$HOME/.zinit/bin/zinit.zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
else
    echo "alread installed zinit"
fi

if [ ! -d $DOTPATH ]; then
    echo "not found: $DOTPATH"
    exit 1
fi

for f in $DOTPATH/.??*
do
    [ "$f" = "$DOTPATH/.git" ] || [ "$f" = "$DOTPATH/.github" ] && continue
    DOTFILES=$(basename $f)
    ln -snfv "$f" "$HOME/$DOTFILES"
done

# Install emacs
if ! type "emacs" > /dev/null 2>&1; then
    if [ "$(uname)" == 'Darwin' ]; then
        brew cask install emacs
    elif [ "$(uname)" == 'Linux' ]; then
        if type "apt" > /dev/null 2>&1; then
            sudo apt install emacs -y
        fi
    fi
else
    echo "already installed emacs"
fi

# Install nmap
if ! type "nmap" > /dev/null 2>&1; then
    if [ "$(uname)" == 'Darwin' ]; then
        brew install nmap
    elif [ "$(uname)" == 'Linux' ]; then
        if type "apt" > /dev/null 2>&1; then
            sudo apt install nmap -y
        fi
    fi
else
    echo "already installed nmap"
fi

# Install Powerline-Go
if ! type "/usr/local/bin/powerline-go" > /dev/null 2>&1; then
    if [ "$(uname)" == 'Darwin' ]; then
        LATEST_POWERLINE_GO_URL=$(curl -s https://api.github.com/repos/justjanne/powerline-go/releases/latest \
                                | grep "browser_download_url.*darwin.*" \
                                | cut -d : -f 2,3)
        curl -L $LATEST_POWERLINE_GO_URL > /usr/local/bin/powerline-go
        chmod /usr/local/bin/powerline-go
    elif [ "$(uname)" == 'Linux' ]; then
        LATEST_POWERLINE_GO_URL=$(curl -s https://api.github.com/repos/justjanne/powerline-go/releases/latest \
                                | grep "browser_download_url.*linux.*" \
                                | cut -d : -f 2,3 \
                                | tr -d '"')
        curl -L $LATEST_POWERLINE_GO_URL > $HOME/powerline-go
        chmod +x $HOME/powerline-go
        mkdir -p $HOME/.powerline-go/bin/
        mv $HOME/powerline-go $HOME/.powerline-go/bin/
    fi
else
    echo "already installed powerline-go"
fi

# Install Rust
if ! type rustc > /dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    echo "already installed Rust"
fi

# Install exa
if ! type exa > /dev/null 2>&1; then
    $HOME/.cargo/bin/cargo install --git https://github.com/ogham/exa
else
    echo "already installed exa"
fi

# Install dutree
if ! type dutree > /dev/null 2>&1; then
    $HOME/.cargo/bin/cargo install dutree
else
    echo "already installed dutree"
fi

# Install GoLang
if ! type go > /dev/null 2>&1; then
    if [ "$(uname)" == 'Darwin' ]; then
        brew install go
    elif [ "$(uname)" == 'Linux' ]; then
        if type "apt" > /dev/null 2>&1; then
            sudo apt install golang -y
        fi
    fi
else
    echo "already installed golang"
fi

# Install ziglang
if ! type zig > /dev/null 2>&1; then
    if [ "$(uname)" == 'Darwin' ]; then
        brew install zig
    elif [ "$(uname)" == 'Linux' ]; then
        if type "apt" > /dev/null 2>&1; then
            sudo apt install zig -y
        fi
    fi
else
    echo "already installed ziglang"
fi


# Install peco
if ! type peco > /dev/null 2>&1; then
    if [ "$(uname)" == 'Darwin' ]; then
        brew install peco
    elif type "apt" > /dev/null 2>&1; then
        sudo apt install -y peco
    fi
else
    echo "already installed peco"
fi

# Install fzf
if ! type fzf > /dev/null 2>&1; then
    if [ "$(uname)" == 'Darwin' ]; then
        brew install fzf
    else
        if [ ! -d "$HOME/.fzf" ]; then
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install
        else
            echo "already installed fzf"
        fi
    fi
else
    echo "already installed fzf"
fi

# Install youtube-dl(macOS only)
if [ "$(uname)" == 'Darwin' ]; then
    if ! type youtube-dl > /dev/null 2>&1; then
        brew install youtube-dl
    else
        echo "already installed youtube-dl"
    fi
fi

# Install pstree(macOS only)
if [ "$(uname)" == 'Darwin' ]; then
    if ! type youtube-dl > /dev/null 2>&1; then
        brew install pstree
    else
        echo "already installed pstree"
    fi
fi

# Install ffmpeg(Ubuntu only)
if type "apt" > /dev/null 2>&1; then
    if ! type ffmpeg > /dev/null 2>&1; then
        sudo apt install -y ffmpeg
    else
        echo "already installed ffmpeg"
    fi
fi

# Install pip3(Ubuntu only)
if type "apt" > /dev/null 2>&1; then
    if ! type pip3 > /dev/null 2>&1; then
        sudo apt install -y python3-pip
    else
        echo "already installed pip3"
    fi
fi

if [ "$SHELL" = "/bin/zsh" ]; then
    echo "If you will use the bash, please enter 'chsh -s $(which bash)'"
else
    echo "If you will use the zsh, please enter 'chsh -s $(which zsh)'"
fi
