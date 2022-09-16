# ----------------------------------------------------------------------------
# XDG
# ----------------------------------------------------------------------------
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.local/cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_LOCAL_BIN_HOME="$HOME/.local/bin"

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
# RUST
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# NODEJS
if [[ $(which node) != "" ]]; then
    if [[ $(grep "prefix" "${HOME}.npmrc" 2>/dev/null) == "" ]]; then
	echo "prefix=${XDG_DATA_HOME}/npm" >> "$HOME/.npmrc"
	echo "cache=${XDG_CACHE_HOME}/npm" >> "$HOME/.npmrc"
	echo "tmp=${XDG_RUNTIME_DIR}/npm" >> "$HOME/.npmrc"
	echo "init-module=${XDG_CONFIG_HOME}/npm/config/npm-init.js" >> "$HOME/.npmrc"
    fi
fi
# PYTHON
export PYTHONSTARTUP="$(realpath $XDG_CONFIG_HOME)/python/pythonrc"
if [[ $(which python3) != "" ]] || [[ $(python -v | grep "3.") != "" ]]; then
    if [[ ! -f "$PYTHONSTARTUP" ]]; then
	mkdir -p $(dirname "$PYTHONSTARTUP")
	cat << EOF > "${PYTHONSTARTUP}"
import os
import atexit
import readline

history = os.path.join(os.environ['XDG_CACHE_HOME'], 'python_history')
try:
    readline.read_history_file(history)
except OSError:
    pass

def write_history():
    try:
        readline.write_history_file(history)
    except OSError:
        pass

atexit.register(write_history)
EOF
    fi
fi

# ----------------------------------------------------------------------------
# CUDA
# ----------------------------------------------------------------------------
export CUDA_CACHE_PATH="$XDG_CACHE_HOME""/nv"

# ----------------------------------------------------------------------------
# GNUPG
# ----------------------------------------------------------------------------
export GNUPGHOME="$XDG_DATA_HOME""/gnupg"

# ----------------------------------------------------------------------------
# X11
# ----------------------------------------------------------------------------
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
#if [[ -f "/etc/X11/xinit/xinitrc" ]] && [[ $(grep "ERRFILE" "/etc/X11/xinit/xinitrc") == "" ]]; then
#    sed -i '/^$/,/^$/s/^$/'"ERRFILE=\"$XDG_CACHE_HOME/X11/xsession-errors\""'/' /etc/hosts
#fi

# ----------------------------------------------------------------------------
# Text editor
# ----------------------------------------------------------------------------
export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/.gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/.vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
