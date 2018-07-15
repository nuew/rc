#!/bin/bash
cmd="xdg-open"
mf="/tmp/mutt-$(id -un)-$(id -u)-url-macros"
url=$(sed -n "$1 {s/.*'\([^']*\)'.*}/\1/; p}" "$mf")
$cmd $url
