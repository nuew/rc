#!/bin/bash
# A simple wrapper around i3lock to take and pixelate a screenshot

decorate_screenshot() {
    fortune="$(fortune -s | sed 's/\t/        /g' | sed 's/--/—/g')"
    convert $1 -scale '2.5%' -scale '4000%' -gravity SouthWest \
      -font /usr/share/fonts/noto/NotoSans-Bold.ttf -pointsize 32 \
      -stroke white -annotate +100+100 "$fortune" $1
}

screenshot=$(mktemp --tmpdir XXXXXXXXXX.png)
import -window root $screenshot
decorate_screenshot $screenshot
i3lock -i $screenshot
rm $screenshot
