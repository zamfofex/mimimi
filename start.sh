#!/bin/sh
set -e

samu -C build
python -m http.server 8017 &

inotifywait -mqre close_write --exclude='^./build/|./meson/|^./nohup\.out$' . |
while read
do samu -C build
done &
