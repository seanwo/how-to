#!/bin/bash

/usr/bin/pkill qbittorrent
/bin/sleep 5s
/usr/bin/pkill -9 qbittorrent
/bin/sleep 5s
env DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/qbittorrent >/dev/null 2>&1

exit 0
