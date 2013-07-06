autoload add-zsh-hook

local TERMWIDTH
(( TERMWIDTH = ${COLUMNS} - 1 ))
local NOCOLOR="%{$terminfo[sgr0]%}"

function get_virtualenv_info() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo " "`basename $VIRTUAL_ENV`
    fi
}

function gpi() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  if [[ x$(parse_git_dirty) == "x✔" ]]; then
    branch_color="%{$fg[green]%}"
  else
    branch_color="%{$fg[red]%}"
  fi
  echo "➜ $(parse_git_dirty) on $branch_color${ref#refs/heads/}%{$NOCOLOR%}"
}

local git='$(gpi)$(git_remote_status)'

ZSH_THEME_GIT_PROMPT_CLEAN="✔"
ZSH_THEME_GIT_PROMPT_DIRTY="✘"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" needs to be pushed"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" needs to be pulled"
ZSH_THEME_GIT_PROMPT_DIVERED_REMOTE=" has diverged"

# rootshell gets another prompt sign
local PR_SIGN=$NOCOLOR
PR_SIGN="%m %{$fg[red]%}∴$NOCOLOR"

# http://unix.stackexchange.com/questions/1022/is-it-possible-to-display-stuff-below-the-prompt-at-a-prompt
terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
vc_status="%{$terminfo_down_sc$git$terminfo[rc]%}" # the second line

PROMPT="$vc_status"
RPROMPT='$NOCOLOR%d$(get_virtualenv_info)'

PROMPT+=$PR_SIGN                 # the user sign
PROMPT+=" "                      # an additional space

eraseSecondLine () {
    print -rn -- $terminfo[el];
    #echo; # this would keep the second line
}
add-zsh-hook preexec eraseSecondLine
