# vi: ft=bash
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
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
function merge_history () {
    builtin fc -R -I "$HISTFILE"
    WORK_HISTORY="$XDG_STATE_HOME/zsh/history_work"
    [ -f "$WORK_HISTORY" ] && builtin fc -R -I "$WORK_HISTORY"
    PERSO_HISTORY="$XDG_STATE_HOME/zsh/history_perso"
    [ -f "$PERSO_HISTORY" ] && builtin fc -R -I "$PERSO_HISTORY"
    # write the loaded history to HISTFILE
    builtin fc -W "$HISTFILE"
}
# END HISTORY

source $ZSH/oh-my-zsh.sh

[[ ! -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh/.p10k.zsh

export GPG_TTY=$(tty)
if command -v nvim &>/dev/null; then
    export EDITOR=nvim
elif command -v vim &>/dev/null; then
    export EDITOR=vim
else
    export EDITOR=nano
fi

# im in the vim matrix
alias :q="exit"
alias ip="ip -color=auto"
alias restartx="sudo systemctl restart lightdm.service"

##############################################################################
# REPLACE COMMAND
local function replace_command() {
    command_replace=$(echo $2 | awk '{print $1;}')
    if command -v $command_replace &> /dev/null
    then
        alias $1="$2"
    fi
}

replace_command "ls"     "eza -lha"
replace_command "cat"    "bat"
replace_command "htop"   "btm"
replace_command "kill"   "fkill"
replace_command "vim"    "nvim"
replace_command "pacman" "paru"

# replace cd command
if command -v zoxide &> /dev/null
then
    if [[ "$INSTALL_ZOXIDE_I" != "ok" ]]; then
	eval "$(zoxide init zsh --cmd z)"
	export INSTALL_ZOXIDE_I="ok"
    fi
fi
if command -v direnv &> /dev/null
then
    eval "$(direnv hook zsh)"
fi

if command -v gpg &> /dev/null && command -v git &> /dev/null
then
    OLD_GIT=$(which git)
    function git () {
        export GPG_TTY=$(tty)
        $OLD_GIT $@
    }
fi

if command -v gpg &> /dev/null && command -v git &>/dev/null && command -v yadm &>/dev/null &> /dev/null
then
    OLD_YADM=$(which yadm)
    function yadm () {
        export GPG_TTY=$(tty)
        $OLD_YADM $@
    }
fi

##############################################################################
# ALIAS
local function alias_if_exists() {
    command_exists=$(echo $2 | awk '{print $1;}')
    if command -v $command_exists &> /dev/null; then
        alias $1="$2"
    fi
}

alias_if_exists "audio-input-toggle"    'pactl set-source-mute @DEFAULT_SOURCE@ toggle'
alias_if_exists "audio-output-toggle"   'pactl set-sink-mute @DEFAULT_SINK@ toggle'
alias_if_exists "scrcpy"                'scrcpy -S -w --power-off-on-close --disable-screensaver '
alias_if_exists "termtosvg"             'python3 -m termtosvg'
alias_if_exists "i3conf"                'nvim $HOME/.config/i3/config'
alias_if_exists "zshconf"               'nvim $HOME/.zshrc'
alias_if_exists "starshipconf"          'nvim $HOME/.config/starship.toml'
alias_if_exists "yarn"                  'yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config '
alias_if_exists "wget"                  'wget --hsts-file="$XDG_DATA_HOME/wget-hsts" '
alias_if_exists "epitest"               'podman run -it --rm -v "$PWD:/code" -w "/code" docker.io/epitechcontent/epitest-docker bash'
# alias_if_exists "epitest"               'docker run -it --rm -v "$PWD:/code" -w "/code" -u "$UID:$GID" docker.io/epitechcontent/epitest-docker bash'
alias_if_exists "nvim"                  'floaterm '

##############################################################################
# PROMPT
# if command -v starship &> /dev/null
# then
#     eval "$(starship init zsh)"
# fi

##############################################################################
# CUSTOM FUNCTION

# search directory name
function searchdir () {
    if [[ "$2" == "" ]]; then
        CHECK="."
    else
        CHECK=$2
    fi
    find $CHECK -type d -name "*$1*"
}

# search file name
function searchfile () {
    if [[ "$2" == "" ]]; then
        CHECK="."
    else
        CHECK=$2
    fi
    find $CHECK -type f -name "*$1*"
}

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

# clean pacman cache
function cleanparu () {
    OLDPKG=$(paru -Qdtq)
    if [[ "$OLDPKG" != "" ]]; then
        paru -Rns $OLDPKG
    fi
    if [[ "$1" == "y" ]]; then
        yes | paru -Scc
    else
        paru -Scc
    fi
}

true_man_intern=$(which man)
if [[ " ${plugins[*]} " == *" colored-man-pages "* ]]; then
    true_man_intern="colored"
elif [[ -z "$(echo $true_man_intern | grep '/bin')" ]]; then
    true_man_intern=""
fi
if [[ -n "$true_man_intern" ]]; then
    function man () {
        if [[ "$1" == "help" ]] || [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
            echo "custom function that call the internal man if next pattern is not respected:"
            echo "-> \$1 == google"
            echo "(open the nexts parameters to browser search)"
            echo "-> \$1 == howto"
            echo "(curl cheat.sh with nexts parameters as research)"
            echo "-> \$1 == how && \$2 == to"
            echo "(same as howto)"
            echo "-> \$1 == howdoi"
            echo "exec howdoi (pip install howdoi)"
            echo "-> the true man with your parameters"
            $true_man_intern man $@ || $true_man_intern "$@"
        elif [[ "$1" == "google" ]]; then
            xdg-open "https://duckduckgo.com/?q=$(echo -n ${@:2} | tr ' ' '+')"
        elif [[ "$1" == "howto" ]]; then
            curl "https://cheat.sh/$(echo ${@:2} | tr ' ' '+')"
        elif [[ "$1" == "how" ]] && [[ "$2" == "to" ]]; then
            curl "https://cheat.sh/$(echo ${@:3} | tr ' ' '+')"
        elif [[ "$1" == "howdoi" ]]; then
            howdoi ${@:3}
        else
            $true_man_intern man "$@" || $true_man_intern "$@"
        fi
    }
fi

alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"

# ----------------------------------------------------------------------------
# from https://github.com/AustralEpitech/.dotfiles/blob/main/.config/zsh/.zsh_aliases
alias umnt='sudo umount /mnt -R'
alias automount='D=$(udisksctl mount -b /dev/sda1 2> /dev/null || udisksctl mount -b /dev/sdb1) && cd ${D/* }'


function fnalias() {
    $1 $(echo "${@:2}" | sed 's/--color=.\+/--color=force/')
}
alias sudo='sudo '
alias watch='fnalias watch -c '
alias xargs='xargs '
# end from
# ----------------------------------------------------------------------------

if command -v fastfetch &>/dev/null; then
    LOCKFILE="/tmp/fastfetchalreadyexecuted"
    if [[ "$NO_NEOFETCH" == "" ]] && [[ ! -f "$LOCKFILE" ]]; then
        touch "$LOCKFILE"
        fastfetch
    fi
fi

# if command -v "change-background.sh" &>/dev/null; then
#     change-background.sh
# fi

[ -f "/home/saverio/.local/share/ghcup/env" ] && source "/home/saverio/.local/share/ghcup/env" || true # ghcup-env

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if command -v thefuck &>/dev/null; then
    eval $(thefuck --alias f)
fi

if command -v kubectx &>/dev/null; then
    function kxn() {
        1="$(echo "$1" | tr -c '[:alnum:]-_' '[ *]')"
        local ctx="$(echo - "$1" | awk '{print $1}')"
        local ns="${2-$(echo - "$1" | awk '{print $2}')}"

        kubectx ${ctx:l}
        [ -n "$ns" ] && kubens "${ns:l}"
    }
fi

if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
fi

# bun completions
[ -s "/home/saverio/.bun/_bun" ] && source "/home/saverio/.bun/_bun"

if command -v atuin &>/dev/null; then
    eval "$(atuin init zsh --disable-up-arrow)"
    source <(atuin gen-completions --shell zsh)
fi
