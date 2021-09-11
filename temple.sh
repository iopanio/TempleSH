#!/bin/bash
#
# Select videos to watch with mpv from the current directory using sxiv.
#
# Caches screenshots for all the videos in the current directory, and then calls
# sxiv on the cache.
#
# requires: ffmpeg
#           sxiv
#           mpv
#
# TODO: only use the current directory if a directory is not provided.


cache=$HOME/.cache/templesh
dir="$*"
if [ -z "$*" ]; then dir="$PWD"; fi

# https://www.youtube.com/watch?v=w_37upFE-qw

# Make sure that correct cache directory exists.
echo $cache/$dir
mkdir -p "$cache/$dir"

# clean up any files in the cache directory that do not correspond to videos in $dir.
echo 'Cleaning cache.'

for f in $cache/$dir/*
do
    if [ -f "$f" ]
    then
	if ! ls | grep -q "$(echo $f | sed 's;.\+/\(.\+\)\.png;\1;')" 
	then
	    rm "$f"
	fi
    fi
done


# Take a screenshot to be thumbnailed for each video in $dir.
# Take it from a fifth of the way through the video,
# and save it in the cache.
echo Building thumbnails

for f in $dir/*mov *mp4 *mkv *webm
do
    if [ -f "$f" ]
    then
	if [ ! -f "$cache/$dir/$f.png" ]
	then  
	    echo "Taking thumbnail for '$f'."
            sstime=$(ffmpeg -y -i "$f" 2>&1 |\
			 awk '/Duration/ { split($2, A, ":"); print (3600*A[1] + 60*A[2] + A[3]) /5 }')

	    ffmpeg -v quiet -y -ss $sstime -i "$f" -vframes 1 "$cache/$dir/$f.png"
	fi
    fi
    #echo $time
done

# Call sxiv on the cache, so that the user can chose videos to watch.
# Store the edited output of sxiv as an array, which can be fed into mpv.
# This way, the entire playlist is sent to one instance of the video player,
# instead of using something like xargs to start a new video player each time
# the previous video player exits.
declare -a playlist
IFS=$'\n'
playlist=($(sxiv -t -o "$cache/$dir/" | sed 's/.png$//' | sed 's;.\+/;;'))
mpv --script-opts=autoload-disabled=yes "${playlist[@]}"
