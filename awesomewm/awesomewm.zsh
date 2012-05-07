
if [[ `uname -r` =~ 'ARCH' ]] && [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi

