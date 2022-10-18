# ----------------------------------------------------------------------------
# XDG
# ----------------------------------------------------------------------------
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.local/cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_LOCAL_BIN_HOME="$HOME/.local/bin"
export XDG_WALLPAPER_HOME="$XDG_DATA_HOME/wallpaper"

if [[ ! -d "$XDG_DATA_HOME" ]]; then
    mkdir -p "$XDG_DATA_HOME"
fi
if [[ ! -d "$XDG_STATE_HOME" ]]; then
    mkdir -p "$XDG_DATA_HOME"
fi
if [[ ! -d "$XDG_CACHE_HOME" ]]; then
    mkdir -p "$XDG_DATA_HOME"
fi
if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
    mkdir -p "$XDG_CONFIG_HOME"
fi

export LANG="en_US.UTF-8"
export LC_LANG="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"

# ----------------------------------------------------------------------------
# SHELL
# ----------------------------------------------------------------------------
# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export PATH="$XDG_LOCAL_BIN_HOME:$PATH"
export ZSH_CUSTOM="$XDG_CONFIG_HOME/ohmyzsh-custom"
# LESS
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
# WGET
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

# ----------------------------------------------------------------------------
# ANDROID
# ----------------------------------------------------------------------------
# ANDROID SDK
export ANDROID_HOME="$XDG_DATA_HOME/android"
# GRADLE
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# ----------------------------------------------------------------------------
# LANGUAGES
# ----------------------------------------------------------------------------
# ASDF
export ASDF_DIR="$XDG_CONFIG_HOME/asdf"
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf-conf/asdfrc"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
# RUST
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# NODEJS
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export PATH="$PATH:$XDG_DATA_HOME/npm/bin"
# PYTHON
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

# ----------------------------------------------------------------------------
# CUDA
# ----------------------------------------------------------------------------
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

# ----------------------------------------------------------------------------
# GNUPG
# ----------------------------------------------------------------------------
export GNUPGHOME="$XDG_DATA_HOME""/gnupg"

# ----------------------------------------------------------------------------
# X11
# ----------------------------------------------------------------------------
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# ----------------------------------------------------------------------------
# Text editor
# ----------------------------------------------------------------------------
export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
