#!/bin/bash

OUTPUT_1=DVI-I-1
OUTPUT_2=DVI-D-1

main() {
  get_background() {
    find "$HOME/media/wallpapers/$1" -type f -iregex "^.*\.\(jpg\|png\)$" \
      -print0 | shuf -zn 1
  }

  if [ -n "$SWAYSOCK" ]; then
    swaymsg output $OUTPUT_1 bg "$(get_background $OUTPUT_1)" fit && \
    swaymsg output $OUTPUT_2 bg "$(get_background $OUTPUT_2)" fit
  else
    feh --no-fehbg  --bg-max "$(get_background $OUTPUT_1)" \
                    --bg-max "$(get_background $OUTPUT_2)"
  fi
}

loop() {
  sleep $1 && main && loop $1
}

main
[[ $1 != "" ]] && loop $1
