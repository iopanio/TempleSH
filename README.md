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
Copy dotfiles and ```temple``` to your system using
```
$ sudo chmod +x setup.sh
$ ./setup.sh
```

# Usage
Pass directory to ```temple```, no input defaults to `$pwd`
```
$ temple DIRECTORY
```
**sxiv usage**
`L-Click` to mark **single** file and `R-Click` for **multiple** files
`Ctrl-x +o` to open marked files with mpv
