#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?* ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# make trackpad tappable
xinput set-prop 14 316 1

# start gnome-keyring daemon
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# add systemd
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# small keymapping changes
# hide mouse pointer
unclutter &
# reform monitor gang
multimonitor-output &

# daemons but in userspace
# picom --config ~/.config/picom/picom.conf &

termite &
hsetroot -solid "#1d2026" &
exec bspwm
