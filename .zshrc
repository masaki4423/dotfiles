# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# no beep
setopt nolistbeep

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# alias

alias ll='exa -alF'
alias la='exa -A'
alias l='exa -F'
alias ls='exa -F'

alias python='python3'
alias pip='pip3'

alias dps='docker ps --format "{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Command}}\t{{.RunningFor}}"'
alias de='docker exec -it `dps | peco | cut -f 1` /bin/bash'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#youtube-dl
alias youtube_mp3='youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0'

# emacsclient
alias emacscli='emacsclient -t'
alias emacskill='emacsclient -e "(kill-emacs)"'

# Powerline-go

if [ -e "$HOME/.powerline-go/bin/powerline-go" ]; then
    POWERLINE_PATH="$HOME/.powerline-go/bin"
else
    POWERLINE_PATH="/usr/local/bin"
fi

function powerline_precmd() {
    PS1="$($POWERLINE_PATH/powerline-go -hostname-only-if-ssh -newline -error $? -shell zsh)"
}

function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
	if [ "$s" = "powerline_precmd" ]; then
        return
	fi
    done
    precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

# zsh-autosuggestions
if [ -e "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# PATH

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

if [ "$(uname)" -eq 'Darwin' ]; then
    export PATH="$HOME/.nodebrew/current/bin:$PATH"
fi
### End of Zinit's installer chunk

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# History search

function select-history() {
    local tac
    if which tac > /dev/null; then
	tac="tac"
    else
	tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N select-history
bindkey '^r' select-history

# load zinit
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
zinit load momo-lab/zsh-abbrev-alias # 略語を展開する
zinit load zsh-users/zsh-syntax-highlighting # 実行可能なコマンドに色付け
zinit load b4b4r07/enhancd
export ENHANCD_FILTER=fzf
# export ENHANCD_DISABLE_DOT=1
export ENHANCD_DISABLE_HOME=1

EMACS_DAEMON_PS_COUNT=`ps aux | grep "emacs --daemon" | wc -l`
if [ $EMACS_DAEMON_PS_COUNT -eq "2" ]; then
    echo "Already launch emacs daemon"
else
    emacs --daemon
fi
