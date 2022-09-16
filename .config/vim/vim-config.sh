#!/bin/bash

if ! command -v vim &> /dev/null
then
        echo "you need to install 'vim'"
	exit 84
fi

if [[ $PWD != */vim ]]; then
	echo "you need to be in 'text-editor/vim/' folder to execute this script"
	exit 84
fi

# vim plugin manager
curl -fLo $XDG_CONFIG_HOME/vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "
-> now,
- open vim,
- run the command ':PlugInstall',
- exit vim,
- go the the folder '$HOME/.vim/plugged/YouCompleteMe/',
- run: python3 install.py --all,
-> GG you have the autocompletion"
