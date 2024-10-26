# ----------------------------------------------------------------------------

PROMPT=""

# command is valid
PROMPT="$PROMPT"'%(?.%F{green}|->.%F{red}|-%?>)%f'

# directory
PROMPT="$PROMPT"' [%B%F{yellow}%~%f%b]'

# git branch
PROMPT="$PROMPT"' vcs:[%B%F{cyan}$(branch_prompt_info)%f%b]'

# admin or user
PROMPT="$PROMPT"' %#'

# end
PROMPT="$PROMPT"'
|-> '

# ----------------------------------------------------------------------------

RPROMPT=""

# kubectl context
if [ $commands[kubectl] ]; then
    RPROMPT=$RPROMPT'$(kube_ps1) '
fi

# time
RPROMPT="$RPROMPT"'(%B%F{blue}%t%f%b)'
