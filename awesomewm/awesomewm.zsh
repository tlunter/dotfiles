if [[ -n `uname -r | grep ARCH` ]] && [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi

