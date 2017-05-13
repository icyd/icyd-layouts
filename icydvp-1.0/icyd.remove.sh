#!/bin/sh
set +x -e

# if argument given, normalize and use as root directory
[ -d "$1" ] && XKB_ROOT=$(readlink -f $1) || XKB_ROOT=/usr/share/X11/xkb

# remove files from the file system
[ -f $XKB_ROOT/symbols/icyd ] && rm -f $XKB_ROOT/symbols/icyd;
