#!/bin/sh

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
dunst &
qutebrowser &
exec i3
