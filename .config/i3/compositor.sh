#!/bin/sh
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    exec xcompmgr -cfCF
fi
