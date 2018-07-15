#!/bin/bash

if [ -n "$SWAYSOCK" ]; then
  WINDOW_1="DVI-I-1"
  WINDOW_2="DVI-D-1"
  SCREENSHOT_1="/var/run/user/$UID/lock.$WINDOW_1.png"
  SCREENSHOT_2="/var/run/user/$UID/lock.$WINDOW_2.png"

  swaygrab -o $WINDOW_1 $SCREENSHOT_1
  swaygrab -o $WINDOW_2 $SCREENSHOT_2

  convert $SCREENSHOT_1 -scale '2.5%' -scale '4000%' -gravity SouthWest \
    -font Sans-Bold -pointsize 32 -stroke white \
    -annotate +100+100 "$(fortune -s | sed 's/\t/        /g' | sed 's/--/—/g')" \
    $SCREENSHOT_1
  convert $SCREENSHOT_2 -scale '2.5%' -scale '4000%' -gravity NorthEast \
    -font DejaVu-Sans-Bold -pointsize 32 -stroke white \
    -annotate +100+100 "\"Accelerating forward with amity\"" $SCREENSHOT_2

  swaylock --image $WINDOW_1:$SCREENSHOT_1 --image $WINDOW_2:$SCREENSHOT_2

  rm $SCREENSHOT_1 $SCREENSHOT_2
else
  SCREENSHOT="/var/run/user/$UID/lock.i3.png"
  import -window root $SCREENSHOT
  convert $SCREENSHOT -scale '2.5%' -scale '4000%' -gravity SouthWest \
    -font /usr/share/fonts/noto/NotoSans-Bold.ttf -pointsize 32 -stroke white \
    -annotate +100+100 "$(fortune -s | sed 's/\t/        /g' | sed 's/--/—/g')" \
    $SCREENSHOT
  i3lock -i $SCREENSHOT
  rm $SCREENSHOT
fi
