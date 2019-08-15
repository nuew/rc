#!/bin/bash
# A simple wrapper around i3lock to take and pixelate a screenshot

take_decorate_screenshot() {
    local screenshot=$(mktemp --tmpdir XXXXXXXXXX.png)
    local fortune="$(fortune -s | sed 's/\t/        /g' | sed 's/--/—/g')"
    grim -s 0.025 -o "$1" "$screenshot"
    convert "$screenshot" -scale '4000%' -gravity SouthWest \
      -font /usr/share/fonts/noto/NotoSans-Bold.ttf -pointsize 32 \
      -stroke white -annotate +100+100 "$fortune" "$screenshot"
    echo "$screenshot"
}

umask 600

screenshot_DP_2=$(take_decorate_screenshot DP-2)
screenshot_HDMI_A_2=$(take_decorate_screenshot HDMI-A-2)

swaylock -i DP-2:"$screenshot_DP_2" -i HDMI-A-2:"$screenshot_HDMI_A_2"
rm "$screenshot_DP_2" "$screenshot_HDMI_A_2"
