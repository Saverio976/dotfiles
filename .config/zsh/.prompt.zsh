
local main_color='%(?.%F{green}.%F{red})'
local main_reset='%f'
local color_magenta='%F{magenta}'
local color_bold='%B'
local color_cyan='%F{cyan}'
local color_yellow='%F{yellow}'
local color_blue='%F{blue}'
local color_reset='%f%b'

local branch_str='vcs'
local branch_info='$(branch_prompt_info)'
local home_dir='%~'
local time_info='%t'

# ----------------------------------------------------------------------------

PROMPT=""

# command is valid
PROMPT="$PROMPT${main_color}󱞫"'%(?.. %?)'"${main_reset}"

# directory
PROMPT="$PROMPT ${main_color}[${main_reset}${color_bold}${color_yellow}${home_dir}${color_reset}${main_color}]${main_reset}"

# git branch
PROMPT="$PROMPT ${color_magenta}${branch_str}${main_reset}${main_color}:[${main_reset}${color_bold}${color_cyan}${branch_info}${color_reset}${main_color}]${main_reset}"

# admin or user
PROMPT="$PROMPT ${main_color}${main_reset}"

# end
PROMPT="$PROMPT""
${main_color}󱞩${main_reset} "

# ----------------------------------------------------------------------------

RPROMPT=""

# kubectl context
if [ $commands[kubectl] ]; then
    RPROMPT=$RPROMPT'$(kube_ps1) '
fi

# time
RPROMPT="$RPROMPT""${main_color}(${main_reset}${color_bold}${color_blue}${time_info}${color_reset}${main_color})${color_reset}"
