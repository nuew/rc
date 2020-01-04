#!/bin/sh
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    xinput set-int-prop 8 291 8 1
    exec xcompmgr -cfCF
fi
