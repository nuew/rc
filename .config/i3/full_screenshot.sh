#!/bin/bash

if [ -n "$SWAYSOCK" ]; then
  WINDOW_1="DVI-I-1"
  WINDOW_2="DVI-D-1"
  SCREENSHOT_1="/var/run/user/$UID/screenshot.$WINDOW_1.png"
  SCREENSHOT_2="/var/run/user/$UID/screenshot.$WINDOW_2.png"

  swaygrab -o $WINDOW_1 $SCREENSHOT_1
  swaygrab -o $WINDOW_2 $SCREENSHOT_2

  convert -gravity SouthWest -background transparent $SCREENSHOT_1 $SCREENSHOT_2 +append $1

  rm $SCREENSHOT_1 $SCREENSHOT_2
else
  import -window root $1
fi
