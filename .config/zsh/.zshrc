# vi: ft=bash

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    fast-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-completions
    kubectl
    docker
    colored-man-pages
    copypath
    copyfile
    docker-compose
    gitignore
    alias-tips
)

fpath+="${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src"

# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format '%F{red}%B completing ...%b%f %F{yellow}%B%d%b%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache/zscache}
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
zstyle :compinstall filename "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc"

autoload -Uz compinit bashcompinit
compinit
bashcompinit

# End of lines added by compinstall

# HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
# END HISTORY

source $ZSH/oh-my-zsh.sh

[[ ! -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh/.p10k.zsh

if [ $commands[nvim] ]; then
    export EDITOR=nvim
elif [ $commands[vim] ]; then
    export EDITOR=vim
else
    export EDITOR=nano
fi

##############################################################################
# INITIALIZE COMMAND

# thefuck init
if [ $commands[thefuck] ]; then
    eval $(thefuck --alias f)
fi

# kubectl completion
if [ $commands[kubectl] ]; then
    source <(kubectl completion zsh)
fi

# stern completion
if [ $commands[stern] ]; then
    source <(stern --completion zsh)
fi

# helm completion
if [ $commands[helm] ]; then
    source <(helm completion zsh)
fi

# atuin
if [ $commands[atuin] ]; then
    # atuin init
    eval "$(atuin init zsh --disable-up-arrow)"
    # atuin completion
    source <(atuin gen-completions --shell zsh)
fi

# load ghc
[ -f "$XDG_DATA_HOME/ghcup/env" ] && source "/home/saverio/.local/share/ghcup/env" || true

# load nvm
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" || true

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun" || true

##############################################################################
# ALIAS

function fnalias() {
    $1 $(echo "${@:2}" | sed 's/--color=.\+/--color=force/')
}

alias ip='ip -color=auto'
alias sudo='sudo '
alias watch='fnalias watch -c '
alias xargs='xargs '
alias epitest='podman run -it --rm -v "$PWD:/code" -w "/code" docker.io/epitechcontent/epitest-docker bash'
alias mirrord='sudo reflector --country FR,GB --latest 300 --protocol https --number 30 --sort rate --save /etc/pacman.d/mirrorlist'

if [ $commands[yarn] ]; then
    alias yarn'yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config '
fi
if [ $commands[wget] ]; then
    alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts" '
fi
if [ $command[floaterm] ]; then
    alias nvim="floaterm"
fi
if [ $commands[eza] ]; then
    alias ls='eza --long --all --icons=auto --group-directories-first --header'
fi

if [ $commands[bat] ]; then
    alias cat=bat
fi

if [ $commands[nvim] ]; then
    alias vi='nvim'
fi

if [ $commands[kubectx] ]; then
    alias kx='kubectx '
    function kxn() {
        1="$(echo "$1" | tr -c '[:alnum:]-_' '[ *]')"
        local ctx="$(echo - "$1" | awk '{print $1}')"
        local ns="${2-$(echo - "$1" | awk '{print $2}')}"

        kubectx ${ctx:l}
        [ -n "$ns" ] && kubens "${ns:l}"
    }
fi
if [ $commands[kubens] ]; then
    alias kn='kubens '
fi

##############################################################################
# CUSTOM FUNCTION

# clean pacman cache
function cleanpacman () {
    OLDPKG=$(pacman -Qdtq)
    if [[ "$OLDPKG" != "" ]]; then
        sudo pacman -Rns $OLDPKG
    fi
    if [[ "$1" == "y" ]]; then
        yes | sudo pacman -Scc
    else
        sudo pacman -Scc
    fi
}
