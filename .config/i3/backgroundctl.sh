#!/bin/bash
# An incredibly simple background switcher

# so named for historical reasons
output_1=DP-2
output_2=HDMI-A-2

main() {
    get_background() {
        find "$HOME/media/wallpapers/$1" -type f -iregex "^.*\.\(jpg\|png\)$" \
            -print0 | shuf -zn 1 | tr -d '\0'
    }

    feh --no-fehbg  --bg-max "$(get_background $output_1)" \
                    --bg-max "$(get_background $output_2)"
}

loop() {
    sleep $1 && main && loop $1
}

# just immediately exit in sway
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    echo hello
    main
    [[ $1 != "" ]] && loop $1
fi
