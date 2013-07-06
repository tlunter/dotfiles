alias reload!=" source ~/.zshrc"

alias p=' ps aux | grep'
alias ls='ls -lhp'

# Removes the terrible .DS_Store files from the Mac OS X operating system
alias dsclean=' find . -type f -name "*.DS_Store" -exec rm -f \{\} \;'

# Treat  the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc.  (An initial unquoted ‘~’ always produces named directory expansion.)
setopt EXTENDED_GLOB

# If a pattern for filename generation has no matches, print an error, instead of leaving it unchanged in the argument  list. This also applies to file expansion of an initial ‘~’ or ‘=’.
setopt NOMATCH

# no Beep on error in ZLE.
setopt NO_BEEP

# Remove  any right prompt from display when accepting a command line. This may be useful with terminals with other cut/paste methods.
setopt TRANSIENT_RPROMPT

# If unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends.
setopt COMPLETE_IN_WORD

autoload -U zmv

# Sets the default editor to Vim
EDITOR=/usr/bin/vim
