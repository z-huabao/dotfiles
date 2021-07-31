#!/usr/bin/python3
""" usage:
    sudo pip3 install xkeysnail
    sudo xkeysnail ~/.xkeysrc.py
"""
import re
from xkeysnail.transform import define_keymap, K
from pykeyboard import PyKeyboard

# open numlock key
k = PyKeyboard()
k.tap_key(k.num_lock_key)

define_keymap(None, {
    # Alt+hjkl to left,down,up,right
    K("Alt-h"): K("LEFT"),
    K("Alt-j"): K("DOWN"),
    K("Alt-k"): K("UP"),
    K("Alt-l"): K("RIGHT"),

    K("Alt-Shift-h"): K("Shift-LEFT"),
    K("Alt-Shift-j"): K("Shift-DOWN"),
    K("Alt-Shift-k"): K("Shift-UP"),
    K("Alt-Shift-l"): K("Shift-RIGHT"),

    K("C-Alt-h"): K("C-Alt-LEFT"),
    K("C-Alt-j"): K("C-Alt-DOWN"),
    K("C-Alt-k"): K("C-Alt-UP"),
    K("C-Alt-l"): K("C-Alt-RIGHT"),

    K("C-Alt-Shift-h"): K("C-Alt-Shift-LEFT"),
    K("C-Alt-Shift-j"): K("C-Alt-Shift-DOWN"),
    K("C-Alt-Shift-k"): K("C-Alt-Shift-UP"),
    K("C-Alt-Shift-l"): K("C-Alt-Shift-RIGHT"),

    K("Alt-i"): K("HOME"),
    K("Alt-a"): K("END"),
    K("C-Alt-i"): K("C-END"),
    K("C-Alt-a"): K("C-HOME"),

    K("Alt-u"): K("Page_Up"),
    K("Alt-d"): K("Page_Down"),
}, "quick move")

define_keymap(None, {
    # capslock to escape
    K("CAPSLOCK"): K("ESC"),
    K("Alt-CAPSLOCK"): K("Alt-ESC"),
}, "caps->esc")

define_keymap(re.compile("Nautilus"), {
    # nautilus Ctrl-Tab
    K("C-TAB"): K("C-Page_Down"),
    K("C-F4"): K("C-w"),
    K("C-Shift-TAB"): K("C-Page_Up"),
}, "nautilus")

define_keymap(re.compile("chrome"), {
    # nautilus Ctrl-Tab
    # K("Alt-h"): K("Alt-LEFT"),
    # K("Alt-j"): K("C-Page_Up"),
    # K("Alt-k"): K("C-Page_Down"),
    # K("Alt-l"): K("Alt-RIGHT"),
    # disable Firefox "alt menu", config on web: 
    #   about:config?filter=ui.key.menuAccessKeyFocuses = false
}, "chrome")
