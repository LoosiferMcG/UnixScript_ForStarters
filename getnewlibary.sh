##getnewlibary.sh
#! /bin/bash
library="$HOME/Upstreams/"
function help() {
  echo "Syntax: $0 'filename'"
  exit 1

if [ ! -f "$1" ]; then help_file; fi
filename="$(basename "$1")"
md5_original="$(md5sum "$1" | cut -d\  -f1)"
newpath="$(find "$library" -name "$filename")"
if [ -z "$newpath" ]; then help_notavailable; fi
md5_new="$(md5sum "$newpath" | cut -d\  -f1)"
echo "$md5_original = $filename"
echo "$md5_new = $newpath"
if [ "$md5_original" != "$md5_new" ]; then
  mv "$1" "$1.original"
  cp -v "$newpath" "$1"
fi
