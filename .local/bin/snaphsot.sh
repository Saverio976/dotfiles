#!/bin/bash

DATE=$$(date --rfc-3339=seconds);

function remove_too_many_prefix() {
    pre="$1"
    dir="$2"
    if [ ! -d "$dir" ]; then
        return 1
    fi
    while [[ "$(/bin/ls "$dir" | grep "$pre" | wc -l)" -gt "5" ]]; do
        to_rem=$(/bin/ls "$dir" | grep "$pre" | head -n 1)
        /bin/rm -r "$dir/$to_rem"
    done
}

remove_too_many_prefix "home-" "/snapshot"
remove_too_many_prefix "root-" "/snapshot"

echo "stating home snapshot..."
/usr/bin/btrfs subvolume snapshot "/home" "/snapshot/home-$DATE"
sleep 20
echo "stating root snapshot..."
/usr/bin/btrfs subvolume snapshot "/" "/snapshot/root-$DATE"
sleep 20
echo "Starting grub reconfig..."
/etc/grub.d/41_snapshots-btrfs
echo "done"
