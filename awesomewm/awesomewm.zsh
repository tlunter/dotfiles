
if [[ `uname -n` == 'snow' ]] && [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi

