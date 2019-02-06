#!/bin/bash
# An incredibly simple background switcher

# so named for historical reasons
output_1=DisplayPort-1
output_2=HDMI-A-1

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

main
[[ $1 != "" ]] && loop $1
