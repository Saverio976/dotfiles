if [ "$ZSHENV_ALREADY_EXECUTED" = "1" ]; then
    return
fi
ZSHENV_ALREADY_EXECUTED="1"

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
alias wget="wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\""

# ----------------------------------------------------------------------------
# ANDROID
# ----------------------------------------------------------------------------
# ANDROID SDK
export ANDROID_HOME="$XDG_STATE_HOME/Android/Sdk"
if [[ -d "$ANDROID_HOME" ]]; then
    export PATH="$PATH:$ANDROID_HOME/emulator"
    export PATH="$PATH:$ANDROID_HOME/platform-tools"
    export PATH="$PATH:$ANDROID_HOME/tools"
    export PATH="$PATH:$ANDROID_HOME/tools/bin"
    if [[ -d "/opt/android-studio" ]]; then
        export PATH="$PATH:/opt/android-studio/bin"
    fi
fi

# ----------------------------------------------------------------------------
# LANGUAGES
# ----------------------------------------------------------------------------
# ASDF
export ASDF_DIR="$XDG_CONFIG_HOME/asdf"
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf-conf/asdfrc"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
# RUST
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PATH="$PATH:$CARGO_HOME/env"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
# NODEJS
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export PATH="$PATH:$XDG_DATA_HOME/npm/bin"
export NVM_DIR="$HOME/.config/nvm"
export BUN_INSTALL="$XDG_STATE_HOME/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# PYTHON
export PYTHON_HISTORY="${XDG_STATE_HOME}/python/history"
#
export KERAS_HOME="${XDG_STATE_HOME}/keras"
# JAVA
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
# GO
export GOPATH="$XDG_DATA_HOME/go"
# HASKELL
export STACK_ROOT="$XDG_DATA_HOME/stack"
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export CABAL_DIR="$XDG_DATA_HOME/cabal"
export GHCUP_USE_XDG_DIRS=true
# V
export VMODULES="$XDG_DATA_HOME/vmodules"

# ----------------------------------------------------------------------------
# CUDA
# ----------------------------------------------------------------------------
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

# ----------------------------------------------------------------------------
# WINE
# ----------------------------------------------------------------------------
export WINEPREFIX="$XDG_DATA_HOME/wine"

# ----------------------------------------------------------------------------
# GNUPG
# ----------------------------------------------------------------------------
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# ----------------------------------------------------------------------------
# X11
# ----------------------------------------------------------------------------
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# ----------------------------------------------------------------------------
# Text editor
# ----------------------------------------------------------------------------
export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'

# ----------------------------------------------------------------------------
# GTK
# ----------------------------------------------------------------------------
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# ----------------------------------------------------------------------------
# NUGET
# ----------------------------------------------------------------------------
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

# ----------------------------------------------------------------------------
# ANSIBLE
# ----------------------------------------------------------------------------
export ANSIBLE_HOME="$XDG_DATA_HOME/ansible"

# ----------------------------------------------------------------------------
# W3M
# ----------------------------------------------------------------------------
export W3M_DIR="$XDG_STATE_HOME/w3m"

# ----------------------------------------------------------------------------
# DOCKER
# ----------------------------------------------------------------------------
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# ----------------------------------------------------------------------------
# kubernetes
# ----------------------------------------------------------------------------
export KUBECONFIG="$XDG_CONFIG_HOME/kube"
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"
export KREW_ROOT="$XDG_DATA_HOME/krew"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
