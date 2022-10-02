# vi: ft=bash
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    asdf
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
)

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
zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-~/.cache/zscache}
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
zstyle :compinstall filename "/home/saverio/${XDG_CONFIG_HOME:-~/.config}/zsh/.zshrc"

autoload -Uz compinit bashcompinit
compinit
bashcompinit

# End of lines added by compinstall

source $ZSH/oh-my-zsh.sh

[[ ! -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh/.p10k.zsh

export GPG_TTY=GPG_TTY=$(tty)
if command -v nvim &>/dev/null; then
    export EDITOR=nvim
elif command -v vim &>/dev/null; then
    export EDITOR=vim
else
    export EDITOR=nano
fi

# im in the vim matrix
alias :q="exit"

alias searchd="s-d"
alias searchf="s-f"
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

replace_command "ls" "exa -la"
replace_command "cat" "bat"
replace_command "htop" "btm"
replace_command "kill" "fkill"

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
	if [[ "$1" == "commit" ]]
	then
	    export GPG_TTY=$(tty)
	fi
	$OLD_GIT $@
    }
fi

##############################################################################
# ALIAS
local function alias_if_exists() {
command_exists=$(echo $2 | awk '{print $1;}')
if command -v $command_exists &> /dev/null
then
    alias $1="$2"
fi
}

alias_if_exists "audio-input-toggle"    "pactl set-source-mute @DEFAULT_SOURCE@ toggle"
alias_if_exists "audio-output-toggle"   "pactl set-sink-mute @DEFAULT_SINK@ toggle"
alias_if_exists "scrcpy"                "scrcpy -S -w --power-off-on-close --disable-screensaver"
alias_if_exists "normatrix"             "$HOME/source/NorMatrix/main.py"
alias_if_exists "termtosvg"             "python3 -m termtosvg"
alias_if_exists "i3conf"                "nvim $HOME/.config/i3/config"
alias_if_exists "zshconf"               "nvim $HOME/.zshrc"
alias_if_exists "starshipconf"          "nvim $HOME/.config/starship.toml"
alias_if_exists "yarn"                  "yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"

##############################################################################
# PROMPT
# if command -v starship &> /dev/null
# then
#     eval "$(starship init zsh)"
# fi

##############################################################################
# CUSTOM FUNCTION

# search directory name
function s-d () {
if [[ "$2" == "" ]]
then
    CHECK="."
else
    CHECK=$2
fi
find $CHECK -type d -name "*$1*"
}

# search file name
function s-f () {
if [[ "$2" == "" ]]
then
    CHECK="."
else
    CHECK=$2
fi
find $CHECK -type f -name "*$1*"
}

# clean pacman cache
function cleanpacman () {
    OLDPKG=$(pacman -Qdtq)
    if [[ "$OLDPKG" != "" ]]
    then
	sudo pacman -Rns $OLDPKG
    fi
    if [[ "$1" == "y" ]]
    then
	yes | sudo pacman -Scc
    else
	sudo pacman -Scc
    fi
}

# clean paru cache
function cleanparu () {
    OLDPKG=$(paru -Qdtq)
    if [[ "$OLDPKG" != "" ]]
    then
	sudo paru -Rns $OLDPKG
    fi
    if [[ "$1" == "y" ]]
    then
	yes | sudo paru -Scc
    else
	sudo paru -Scc
    fi
}

# clean yay cache
function cleanyay () {
    OLDPKG=$(yay -Qdtq)
    if [[ "$OLDPKG" != "" ]]
    then
	sudo yay -Rns $OLDPKG
    fi
    if [[ "$1" == "y" ]]
    then
	yes | sudo yay -Scc
    else
	sudo yay -Scc
    fi
}

true_man_intern=$(which man)
function man () {
    if [[ "$1" == "google" ]]; then
	xdg-open "https://duckduckgo.com/?q=${@:1}"
    elif [[ "$1" == "howto" ]]; then
	curl "https://cheat.sh/$(echo ${@:2} | tr ' ' '+')"
    elif [[ "$1" == "how" ]] && [[ "$2" == "to" ]]; then
	curl "https://cheat.sh/$(echo ${@:3} | tr ' ' '+')"
    else
	$true_man_intern "$@"
    fi
}

alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"

if command -v neofetch &>/dev/null; then
    neofetch
fi
