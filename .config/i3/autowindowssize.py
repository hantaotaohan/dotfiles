#!/usr/bin/env python3

import i3ipc

def on(i3, e):
    i3 = i3ipc.Connection()
    workspace = i3.get_tree().find_focused().workspace().num
    if e.container.window_class in ['Microsoft-edge-dev',  'Alacritty'] and workspace == 10:
        e.container.command('resize set 0 ppt 90 ppt')

i3 = i3ipc.Connection()
i3.on('window::focus', on)

try:
    i3.main()
finally:
    i3.main_quit()
