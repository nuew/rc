#!/bin/sh

cache_limit=51200

cd "$1" 2>/dev/null
[ $? -ne 0 ] && exit

[ $(du -s . | cut -f1 -d'	') -lt $cache_limit ] && exit
while IFS= read -r i; do
	rm "$i"
	[ $(du -s . | cut -f1 -d'	') -lt $cache_limit ] && exit
done <<EOF
$(find . -type f -exec ls -rt1 {} +)
EOF
