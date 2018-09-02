#!/bin/bash
# Manages Sway Exclusive Settings

if [ -n "$SWAYSOCK" ]; then
  # Gaps
  swaymsg gaps 5
  swaymsg gaps edge_gaps off

  # Window Configuration
  swaymsg output DVI-I-1 res 1920x1080 pos 0,0
  swaymsg output DVI-D-1 res 1280x1024 pos 1920,56
else
  # Keyboard Mapping
  setxkbmap -layout us -variant alt-intl-unicode -option caps:super

  # X11 Bell
  pactl upload-sample /usr/share/sounds/freedesktop/stereo/bell.oga x11-bell
  pactl load-module module-x11-bell sample=x11-bell display=$DISPLAY

  # Redshift
  redshift -l 40.47:-79.95 -m randr -P -t 6500:4000 &

  # Systemd lock daemon
  xss-lock -- "$HOME/.config/i3/lock.sh" &

  # X11 Compositor
  exec xcompmgr -FCf
fi
