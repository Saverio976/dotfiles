#
# ~/.bashrc
#

. "$HOME/.config/zsh/.zshenv"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

HISTFILE=""
source "/home/saverio/.local/share/cargo/env"