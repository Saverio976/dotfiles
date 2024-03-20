if command -v alacritty 2>/dev/null; then
    exec alacritty
elif [ -x $HOME/.local/bin/alacritty ]; then
    exec "$HOME/.local/bin/alacritty"
elif command -v kitty 2>/dev/null; then
    exec kitty
elif [ -x $HOME/.local/bin/kitty ]; then
    exec "$HOME/.local/bin/kitty"
elif command -v foot 2>/dev/null; then
    exec foot
elif [ -x $HOME/.local/bin/foot ]; then
    exec "$HOME/.local/bin/foot"
elif command -v xterm 2>/dev/null; then
    exec xterm
fi
