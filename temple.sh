#!/bin/bash

dir="$*"
if [ -z "$*" ]; then dir="$PWD"; fi
for f in *mov *mp4 *mkv *webm
do
	if [ ! -f "$dir/$f.png" ]
	then  
            sstime=$(ffmpeg -y -i "$f" 2>&1 |\
			 awk '/Duration/ { split($2, A, ":"); print (3600*A[1] + 60*A[2] + A[3]) /5 }')
	    ffmpeg -v quiet -y -ss $sstime -i "$f" -vframes 1 "$(echo $f | sed 's/mp4/png/')"
	fi
done
