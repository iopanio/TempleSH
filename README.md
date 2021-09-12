# TempleSH
Video file support (mp4, webm) for sxiv. Uses mpv as image and video player.

# Features
- Create *.png* thumbnails for video files not compatible with sxiv
- Stream *.mp4* and *.webm* video files in sxiv
- Browse multimedia files (jpg, png, mp4, webm) inside sxiv

# Dependencies
- ffmpeg [https://github.com/FFmpeg/FFmpeg]
- mpv [https://github.com/mpv-player/mpv]
- sxiv [https://github.com/muennich/sxiv]

# Building
Copy dotfiles and templesh to your system using
```
$ sudo chmod +x setup.sh
$ ./setup.sh
```

# Usage
Pass directory to templesh, no input defaults to `$pwd`
```
$ temple <your-directory-here>
```
**sxiv usage**
`Right Click` to mark file to be opened
`Ctrl-x +o` to open marked files with mpv
