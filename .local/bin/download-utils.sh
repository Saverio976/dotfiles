echo "Do you want omyzsh"
echo "bash script: https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
echo "[Y/n] "
read CHOICE
if [[ "$CHOICE" == "Y" ]] || [[ "$CHOICE" == "y" ]] || [[ "$CHOICE" == "" ]]; then
    if [[ "$ZSH" == "" ]]; then
    export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
    fi
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Do you want a better docker purge (binary name -> dkpurge)"
echo "bash script: https://raw.githubusercontent.com/AustralEpitech/.dotfiles/work/bin/dkpurge"
echo "[Y/n] "
read CHOICE
if [[ "$CHOICE" == "Y" ]] || [[ "$CHOICE" == "y" ]] || [[ "$CHOICE" == "" ]]; then
    curl https://raw.githubusercontent.com/AustralEpitech/.dotfiles/work/bin/dkpurge > $XDG_LOCAL_BIN_HOME/dkpurge
    chmod +x $XDG_LOCAL_BIN_HOME/dkpurge
fi

echo "Do you want VimPlug"
echo "bash script: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
echo "[Y/n] "
read CHOICE
if [[ "$CHOICE" == "Y" ]] || [[ "$CHOICE" == "y" ]] || [[ "$CHOICE" == "" ]]; then
    curl -fLo $XDG_CONFIG_HOME/vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
