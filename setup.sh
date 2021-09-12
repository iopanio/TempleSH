#!/bin/bash

chmod +x temple
sudo cp temple /usr/local/bin/

cat .Xresources >> ~/.Xresources
xrdb -merge .Xresources
cat .xinitrc >> ~/.xinitrc

chmod +x key-handler
mkdir -p ~/.config/sxiv/exec/
cp key-handler ~/.config/sxiv/exec/
