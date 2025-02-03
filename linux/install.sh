#!/bin/bash
set +x -e

# if argument given, normalize and use as root directory
[ -d "$1" ] && XKB_ROOT=$(readlink -f "$1") || XKB_ROOT=/usr/share/X11/xkb

# owner may be given as the second argument, for local installation
[ -n "$2" ] && OWNER=$2 || OWNER=root

# find our own location
CURR_DIR="$(dirname "$(readlink -f "$0")")"

# copy files to the appropriate location
while IFS= read -r -d '' file; do
    install -m 644 -o "$OWNER" -g "$OWNER" "$CURR_DIR/$file" "$XKB_ROOT/$file"
done < <(find symbols types -type f -print0)
