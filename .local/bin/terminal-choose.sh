if command -v st 2>/dev/null; then
    exec st "${@:2}"
elif command -v alacritty 2>/dev/null; then
    exec alacritty "${@:2}"
elif [ -x $HOME/.local/bin/alacritty ]; then
    exec "$HOME/.local/bin/alacritty" "${@:2}"
elif command -v kitty 2>/dev/null; then
    exec kitty "${@:2}"
elif [ -x $HOME/.local/bin/kitty ]; then
    exec "$HOME/.local/bin/kitty" "${@:2}"
elif command -v foot 2>/dev/null; then
    exec foot "${@:2}"
elif [ -x $HOME/.local/bin/foot ]; then
    exec "$HOME/.local/bin/foot" "${@:2}"
elif command -v xterm 2>/dev/null; then
    exec xterm "${@:2}"
fi
