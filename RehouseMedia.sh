#RehouseMedia.sh
#!/bin/bash

#Setting the debug options
debug_echo() {
  if [ -n "$DEBUG" ]; then
    echo "$1"
  fi
}

if [ -z "$1" ] || [ ! -f "$1" ]; then
  echo "Missing source file"
  exit 1
fi
if [ -z "$2" ]; then
  echo "Missing target owner"
  exit 1
elif [ -f "~/Dropbox/Stored Photos for ${2}" ]; then
  TARGET_PHOTO="Stored Photos for ${2}"
  TARGET_VIDEO="Stored Videos for ${2}"
  TARGET_AUDIO="Stored Audio for ${2}"
else
  echo "No valid target"
  exit 1
fi

# Based on https://stackoverflow.com/a/47706445 and https://stackoverflow.com/questions/47706415/how-does-this-bash-script-work/47706445#comment82373061_47706445
#Sorting the files into Audio, photo or video based on their file extensions.
if [[ "${1: -4}" =~ ^.([Jj][Pp][Gg])$ ]] || [[ "${1: -5}" =~ ^.([Jj][Pp][Ee][Gg])$ ]] || [[ "${1: -4}" =~ ^.([Pp][Nn][Gg])$ ]] || [[ "${1: -4}" =~ ^.([Gg][Ii][Ff])$ ]]; then
  TARGET="$TARGET_PHOTO"
elif [[ "${1: -4}" =~ ^.([Mm][Pp]4)$ ]] || [[ "${1: -4}" =~ ^.(3[Gg][Pp])$ ]] || [[ "${1: -4}" =~ ^.([Aa][Vv][Ii])$ ]] || [[ "${1: -4}" =~ ^.([Mm]4[Vv])$ ]]; then
  TARGET="$TARGET_VIDEO"
elif [[ "${1: -4}" =~ ^.([Mm][Pp]3)$ ]] || [[ "${1: -4}" =~ ^.([Ww][Aa][Vv])$ ]]; then
  TARGET="$TARGET_AUDIO"
else
  echo "Unknown file format"
  exit 1
fi

#Setting the varaiables of the source yr and month
SOURCE_YEAR="$(echo $1 | sed -r 's/^[^0-9]*([0-9]{4})-?[0-9]{2}.*/\1/')"
SOURCE_MONTH="$(echo $1 | sed -r 's/^[^0-9]*[0-9]{4}-?([0-9]{2}).*/\1/')"

#Perform final sort of the files into Dropbox folder based on the month/year and whether audio, photos or video files
# N.B. this doesn't have to be a dropbox folder, can be anything you chose it to be e.g. Amazon Photos, Amazon Drive.
debug_echo "Moving $1 to ~/Dropbox/$TARGET/$SOURCE_YEAR/$SOURCE_YEAR-$SOURCE_MONTH/"
mkdir -p "$HOME/Dropbox/$TARGET/$SOURCE_YEAR/$SOURCE_YEAR-$SOURCE_MONTH/"
if [ -n "$DEBUG" ]; then
  mv -v "$1" "$HOME/Dropbox/$TARGET/$SOURCE_YEAR/$SOURCE_YEAR-$SOURCE_MONTH/"
else
  mv "$1" "$HOME/Dropbox/$TARGET/$SOURCE_YEAR/$SOURCE_YEAR-$SOURCE_MONTH/"
fi
