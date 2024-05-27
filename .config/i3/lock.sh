#!/bin/sh

bg_color="$1"
bg_image="$2"
nofork="$3"

revert() {
    xset -dpms
}

if [ "$nofork" = "--nofork" ]; then
    trap revert HUP INT TERM
    xset +dpms dpms 5 5 5
    i3lock \
        --color "$bg_color" \
        --image "$bg_image" \
        --show-failed-attempts \
        --ignore-empty-password \
        --tiling \
        $nofork
    revert
else
    i3lock \
        --color "$bg_color" \
        --image "$bg_image" \
        --show-failed-attempts \
        --ignore-empty-password \
        --tiling \
        && (systemctl suspend-then-hibernate || systemctl suspend)
fi
