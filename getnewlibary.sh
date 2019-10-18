#! /bin/bash
library="$HOME/Upstreams/"
function help() {
  echo "Syntax: $0 'filename'"
  echo "This script will replace the file you provide with an exactly-the-same named version in $library"
  exit 1
}
function help_file() {
  echo "Missing file! (You may have passed a directory?)"
  help
}
function help_notavailable() {
  echo "This file does not exist. Skipping."
  exit 0
}
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
