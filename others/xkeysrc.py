#!/usr/bin/python3
""" usage:
    sudo pip3 install xkeysnail
    sudo xkeysnail ~/.xkeysrc
"""
from xkeysnail.transform import *
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

    K("Alt-i"): K("HOME"),
    K("Alt-a"): K("END"),
    K("C-Alt-i"): K("C-END"),
    K("C-Alt-a"): K("C-HOME"),

    K("C-Alt-h"): K("C-Alt-LEFT"),
    K("C-Alt-j"): K("C-Alt-DOWN"),
    K("C-Alt-k"): K("C-Alt-UP"),
    K("C-Alt-l"): K("C-Alt-RIGHT"),

    K("C-Alt-Shift-h"): K("C-Alt-Shift-LEFT"),
    K("C-Alt-Shift-j"): K("C-Alt-Shift-DOWN"),
    K("C-Alt-Shift-k"): K("C-Alt-Shift-UP"),
    K("C-Alt-Shift-l"): K("C-Alt-Shift-RIGHT"),
}, "hjkl")

define_keymap(None, {
    K("CAPSLOCK"): K("ESC"),
}, "caps->esc")

