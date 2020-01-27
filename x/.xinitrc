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

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh 

# key aliases
xmodmap ~/.Xmodmap &
# short press on caps lock is escape
xcape -e 'Hyper_L=Escape' & 
# hide mouse pointer when not in use
unclutter &
# dropbox
dropbox &
# reform monitor gang
multimonitor-output &
# compositor
picom --config ~/.config/picom/picom.conf &  
# start wm
exec i3
