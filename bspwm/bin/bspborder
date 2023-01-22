#!/bin/sh
# Enable double borders
# Dependencies: chwb2 from wmutils/opt
#
# Yes, this is stolen from gk.

outer='0x09090A'   # outer
inner1='0x303134'  # focused
inner2='0x242427'  # normal

trap 'bspc config border_width 0; kill -9 -$$' INT TERM

targets() {
    case $1 in
        focused) bspc query -N -n .local.focused.\!fullscreen;;
        normal)  bspc query -N -n .local.\!focused.\!fullscreen
    esac | grep -iv "$v"
}

#8
bspc config border_width 3

#2 6
draw() { chwb2 -I "$inner" -O "$outer" -i "1" -o "2" $* |:; }

#initial draw, and then subscribe to events
{ echo; bspc subscribe node_geometry node_focus; } |
    while read -r _; do
        [ "$v" ] || v='abcdefg'
        inner=$inner1 draw "$(targets focused)"
        inner=$inner2 draw "$(targets normal)"
        done
        
