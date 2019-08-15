#!/bin/bash
# An incredibly simple background switcher

DISPLAYS="DP-2 HDMI-A-2"

update_background() {
    get_background() {
        find "$HOME/media/wallpapers/$1" -type f -iregex "^.*\.\(jpg\|png\)$" \
            -print0 | shuf -zn 1 | tr -d '\0'
    }

    swaymsg output "$1" background "$(get_background $1)" fit
}

main() {
    for display in $DISPLAYS; do update_background $display; done
}

loop() {
    sleep $1 && main && loop $1
}

main
[[ $1 != "" ]] && loop $1
