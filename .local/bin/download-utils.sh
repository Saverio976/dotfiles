echo "Do you want omyzsh"
echo "bash script: https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
echo "[y/N] "
read CHOICE
if [[ "$CHOICE" == "Y" ]] || [[ "$CHOICE" == "y" ]]; then
    if [[ "$ZSH" == "" ]]; then
    export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
    fi
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Do you want a better docker purge (binary name -> dkpurge)"
echo "bash script: https://raw.githubusercontent.com/AustralEpitech/.dotfiles/work/bin/dkpurge"
echo "[y/N] "
read CHOICE
if [[ "$CHOICE" == "Y" ]] || [[ "$CHOICE" == "y" ]]; then
    curl https://raw.githubusercontent.com/AustralEpitech/.dotfiles/work/bin/dkpurge > $XDG_LOCAL_BIN_HOME/dkpurge
    chmod +x $XDG_LOCAL_BIN_HOME/dkpurge
fi

echo "Do you want neovim appimage ("'$VERSION' by default is v0.7.2 but you cant set it")"
echo "downloader link: https://github.com/neovim/neovim/releases/download/"'$VERSION'"/nvim.appimage"
echo "[y/N]"
read CHOICE
if [[ "$CHOICE" == "Y" ]] || [[ "$CHOICE" == "y" ]]; then
    echo "Which version (tag release): [v0.7.2] "
    read NVIM_VERSION
    if [[ "$NVIM_VERSION" == "" ]]; then
        NVIM_VERSION="v0.7.2"
    fi
    curl -L https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim.appimage -o $XDG_LOCAL_BIN_HOME/nvim
    chmod +x $XDG_LOCAL_BIN_HOME/nvim
fi

echo "Do you want zoxide (smart cd)"
echo "downloader link: https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh"
echo "[y/N]"
read CHOICE
if [[ "$CHOICE" == "Y" ]] || [[ "$CHOICE" == "y" ]]; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

echo "Do you want bash_color (show color number in terminal)"
echo "file: https://raw.githubusercontent.com/Remi-Mergen/bash_color/master/color.sh"
echo "[y/N]"
read CHOICE
if [[ "$CHOICE" == "Y" ]] || [[ "$CHOICE" == "y" ]]; then
    curl -Lo "$XDG_LOCAL_BIN_HOME/color.sh" https://raw.githubusercontent.com/Remi-Mergen/bash_color/master/color.sh
    chmod +x "$XDG_LOCAL_BIN_HOME/color.sh"
fi
