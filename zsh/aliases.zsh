
export EDITOR="vim"
alias reload!=" source ~/.zshrc"
alias aedit=" $EDITOR $ZSH/zsh/aliases.zsh; reload!"
alias fedit=" $EDITOR $ZSH/zsh/functions.zsh; reload!"
alias pedit=" $EDITOR $ZSH/zsh/prompt.zsh; reload!"
alias oedit=" $EDITOR $ZSH/zsh/options.zsh; reload!"
alias vedit=" $EDITOR $ZSH/vim/vimrc.symlink"
alias gedit=" $EDITOR $ZSH/git/gitconfig.symlink"

#alias man="unset PAGER; man"
#alias grep='grep --color=auto'

##### standard aliases (start with a space to be ignored in history)
# default ls is untouched, except coloring
alias ls='ls -lph'
alias ll='ls -l'
alias la='ls -A'
alias v=" clear; ll -g"    # standard directory view
alias vs=" v **/*(.)"         # show all files in all subdirs plain in a list

alias p=' ps aux | grep'
alias g='git'
alias d=' dirs -v'
alias ka="killall"

# Removes the terrible .DS_Store files from the Mac OS X operating system
alias dsclean=' find . -type f -name "*.DS_Store" -exec rm -f \{\} \;'

#alias .='xdg-open .'
alias cd='cd'
alias ..=' cd ..; ls'
alias ...=' cd ..; cd ..; ls'
alias ....=' cd ..; cd ..; cd ..; ls'
alias cd..='..'
alias cd...='...'
alias cd....='....'
