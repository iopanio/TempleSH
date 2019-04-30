#!/bin/sh
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


cache=$HOME/.cache/mpvthumbselect

# https://www.youtube.com/watch?v=w_37upFE-qw

# Make sure that correct cache directory exists.
mkdir -p "$cache/$PWD"

# clean up any files in the cache directory that do not correspond to videos in $PWD.
echo 'Cleaning cache.'

for f in $cache/$PWD/*
do
    if [ -f "$f" ]
    then
	if ! ls | grep -q "$(echo $f | sed 's;.\+/\(.\+\)\.png;\1;')" 
	then
	    rm "$f"
	fi
    fi
done


# Take a screenshot to be thumbnailed for each video in $PWD.
# Take it from a fifth of the way through the video,
# and save it in the cache.
echo Building thumbnails

for f in *mov *mp4 *mkv *webm
do
    if [ -f "$f" ]
    then
	if [ ! -f "$cache/$PWD/$f.png" ]
	then  
	    echo "Taking thumbnail for '$f'."
            sstime=$(ffmpeg -y -i "$f" 2>&1 |\
			 grep Duration |\
			 cut -d ' ' -f 4 |\
			 sed 's@\..*@@g' |\
			 awk '{ split($1, A, ":"); print (3600*A[1] + 60*A[2] + A[3]) /5 }')

	    ffmpeg -v quiet -y -ss $sstime -i "$f" -vframes 1 "$cache/$PWD/$f.png"
	fi
    fi
    #echo $time
done

# Call sxiv on the cache, so that the user can chose videos to watch.
# Store the edited output of sxiv as an array, which can be fed into $video player.
# This way, the entire playlist is sent to one instance of the video player,
# instead of using something like xargs to start a new video player each time
# the previous video player exits.
declare -a playlist
IFS=$'\n'
playlist=($(sxiv -t -o "$cache/$PWD/" | sed 's/.png$//' | sed 's;.\+/;;'))
mpv "${playlist[@]}"
