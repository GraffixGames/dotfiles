#!/usr/bin/env python3

# Script from https://github.com/swaywm/sway/blob/master/contrib/inactive-windows-transparency.py

import i3ipc

transparency = '0.9'
ipc          = i3ipc.Connection()
last_focus   = None

for window in ipc.get_tree():
    if window.focused:
        last_focus = window
    else:
        window.command('opacity ' + transparency)

def on_window_focus(ipc, focused):
    global last_focus
    if focused.container.id != last_focus.id:
        focused.container.command('opacity 1')
        last_focus.command('opacity ' + transparency)
        last_focus = focused.container

ipc.on("window::focus", on_window_focus)
ipc.main()
