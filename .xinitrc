#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#xinput set-prop "Logitech G203 Prodigy Gaming Mouse" 154 2.000000, 0.000000, 0.000000, 0.000000, 2.000000, 0.000000, 0.000000, 0.000000, 1.00000
#xset dpms 60000 60000 60000
#xset -dpms 
#xset s 0 0
#xset m 0 0
export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
export QT_QPA_PLATFORMTHEME="qt5ct"
#export SDL_VIDEO_X11_FORCE_EGL=true
export GTK_THEME="Sweet-Dark-v40"

export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
export XMODIFIERS='@im=uim'
uim-xim &
#GTK_IM_MODULE='ibus'
#QT_IM_MODULE='ibus'
#XMODIFIERS='@im=ibus'
#ibus-daemon -drxR

export __GL_SYNC_TO_VBLANK=1
export __GL_SYNC_DISPLAY_DEVICE=HDMI-0
export VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE=HDMI-0

session=${1:-i3}

chrome="chromium"
chrome="google-chrome"
#echo ${@:2} > ~/awjkdhakjwhdlkawjhdkljhogfhdfoigho
case $session in
	i3|i3		) exec i3 ${@:2};;
	lxde		) exec startlxde ${@:2};;
	kde|plasma	) exec startplasma-x11 ${@:2};;
	gnome		) exec gnome-session ${@:2};;
	dde|deepin	) exec startdde ${@:2};;
	e17		) exec enlightenment_start ${@:2};;
	xfce|xfce4	) exec startxfce4 ${@:2};;
	chrome		) exec $chrome --window-size=1920,1080 --no-sandbox ${@:2};;
	*		) exec $1 ${@:2};;
esac
