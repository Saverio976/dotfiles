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

if command -v nvim &>/dev/null; then
    export EDITOR=nvim
elif command -v vim &>/dev/null; then
    export EDITOR=vim
else
    export EDITOR=nano
fi

##############################################################################
# INITIALIZE COMMAND

# thefuck init
command -v thefuck &>/dev/null && eval $(thefuck --alias f) || true

# zoxide init
command -v zoxide &>/dev/null && eval "$(zoxide init zsh --cmd z)" || true

# fix GPG_TTY not set
if command -v gpg &> /dev/null && command -v git &> /dev/null
then
    OLD_GIT=$(which git)
    function git () {
        export GPG_TTY=$(tty)
        $OLD_GIT $@
    }
fi

# fix GPG_TTY not set
if command -v gpg &> /dev/null && command -v git &>/dev/null && command -v yadm &>/dev/null &> /dev/null
then
    OLD_YADM=$(which yadm)
    function yadm () {
        export GPG_TTY=$(tty)
        $OLD_YADM $@
    }
fi

# kubectl completion
command -v kubectl &>/dev/null && source <(kubectl completion zsh) || true

# stern completion
command -v stern &>/dev/null && source <(stern --completion zsh) || true

# helm completion
command -v helm &>/dev/null && source <(helm completion zsh) || true

# atuin init
command -v atuin &>/dev/null && eval "$(atuin init zsh --disable-up-arrow)" || true
# atuin completion
command -v atuin &>/dev/null && source <(atuin gen-completions --shell zsh) || true

# load ghc
[ -f "$XDG_DATA_HOME/ghcup/env" ] && source "/home/saverio/.local/share/ghcup/env" || true

# load nvm
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" || true

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun" || true

##############################################################################
# ALIAS

local function alias_if_exists() {
    command_exists=$(echo $2 | awk '{print $1;}')
    if [[ "$command_exists" == "sudo" ]] && command -v "$command_exists" &>/dev/null; then
        command_exists=$(echo $2 | awk '{print $2;}')
    fi
    if command -v "$command_exists" &>/dev/null; then
        alias $1="$2"
    fi
}

function fnalias() {
    $1 $(echo "${@:2}" | sed 's/--color=.\+/--color=force/')
}

alias sudo='sudo '
alias watch='fnalias watch -c '
alias xargs='xargs '
alias_if_exists "mount"                 'udisksctl mount -b '
alias_if_exists "unmount"               'udisksctl unmount -b '
alias_if_exists "audio-input-toggle"    'pactl set-source-mute @DEFAULT_SOURCE@ toggle'
alias_if_exists "audio-output-toggle"   'pactl set-sink-mute @DEFAULT_SINK@ toggle'
alias_if_exists "scrcpy"                'scrcpy -S -w --power-off-on-close --disable-screensaver '
alias_if_exists "termtosvg"             'python3 -m termtosvg'
alias_if_exists "yarn"                  'yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config '
alias_if_exists "wget"                  'wget --hsts-file="$XDG_DATA_HOME/wget-hsts" '
alias_if_exists "epitest"               'podman run -it --rm -v "$PWD:/code" -w "/code" docker.io/epitechcontent/epitest-docker bash'
alias_if_exists "epitest"               'docker run -it --rm -v "$PWD:/code" -w "/code" -u "$UID:$GID" docker.io/epitechcontent/epitest-docker bash'
alias_if_exists "nvim"                  'floaterm '
alias_if_exists "mirrord"               'sudo reflector --country FR,GB --latest 300 --protocol https --number 30 --sort rate --save /etc/pacman.d/mirrorlist'
alias_if_exists "ls"                    'eza --long --all --icons=auto --group-directories-first --header'
alias_if_exists "cat"                   'bat'
alias_if_exists "htop"                  'btop'
alias_if_exists "vim"                   'nvim'
alias_if_exists "vi"                    'nvim'
alias_if_exists "ip"                    'ip -color=auto'
alias_if_exists "kx"                    'kubectx '
alias_if_exists "kx-"                   'kubectx -'
alias_if_exists "kn"                    'kubens '
alias_if_exists "kn-"                   'kubens -'

if command -v kubectx &>/dev/null; then
    function kxn() {
        1="$(echo "$1" | tr -c '[:alnum:]-_' '[ *]')"
        local ctx="$(echo - "$1" | awk '{print $1}')"
        local ns="${2-$(echo - "$1" | awk '{print $2}')}"

        kubectx ${ctx:l}
        [ -n "$ns" ] && kubens "${ns:l}"
    }
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
