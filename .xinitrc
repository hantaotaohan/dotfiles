#!/usr/bin/env bash

export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
fcitx &
xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
dunst &
qutebrowser &
exec i3
