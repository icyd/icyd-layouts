#!/bin/bash
set +x -e

# if argument given, normalize and use as root directory
[ -d "$1" ] && XKB_ROOT="$(readlink -f "$1")" || XKB_ROOT=/usr/share/X11/xkb

# remove files from the file system
while IFS= read -r -d '' file; do
    [ -f "$XKB_ROOT/$file" ] && rm -f "$XKB_ROOT/file"
done < <(find symbols types -type f -print0)
