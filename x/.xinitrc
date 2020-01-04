#!/bin/sh

userresources=$HOME/.Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# make trackpad tappable
xinput set-prop 14 301 1
xinput set-prop 14 302 1

# start gnome-keyring daemon
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# bind keys to x
xbindkeys & 
# hide mouse pointer when not in use
unclutter &
# dropbox
dropbox &
# start wm
exec i3
