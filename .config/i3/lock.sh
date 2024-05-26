#!/bin/sh

bg_color="$1"
bg_image="$2"
i3lock_option="$3"

revert() {
    xset -dpms
}
trap revert HUP INT TERM
xset +dpms dpms 5 5 5
i3lock \
    --color "$bg_color" \
    --image "$bg_image" \
    --show-failed-attempts \
    --ignore-empty-password \
    --show-keyboard-layout \
    --tiling \
    $i3lock_option
revert
