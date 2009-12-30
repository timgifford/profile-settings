#!/bin/sh
path="$(cygpath "$1")"
old="$(cygpath --mixed --absolute "$2")"
new="$(cygpath --mixed --absolute "$5")"

"/cygdrive/C/opt/DiffMerge/diffmerge.exe" "$old" "$new" --title1="Old" --title2="New $path" --nosplash

