# enable hook method
autoload add-zsh-hook

autoload colors && colors

git_prompt_info () {
    ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
    echo "${ref#refs/heads/}"
}

unpushed () {
    /usr/bin/git cherry -v @{upstream} 2>/dev/null
}

need_push () {
    if [[ $(unpushed) == "" ]]
    then
        echo " "
    else
        echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
    fi
}


# my prompt theme
promptSetup () {
    setopt prompt_subst
    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))

    NOCOLOR="%{$terminfo[sgr0]%}"
    PS1=''; RPS1='%d'
    PS2="↷ %_>"; RPS2=''
    PS3="↷ ?#"; RPS3=''
    PS4="↷ +i>"; RPS3=''

    # prepare vcs info
    VCS_LINE=''
    VCS_LINE+=$NOCOLOR
    st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
    if [[ $st != "" ]]; then
        if [[ $st == "nothing to commit (working directory clean)" ]]; then
            VCS_LINE+="➜ ± on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
        else
            VCS_LINE+="➜ ± on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
        fi
        VCS_LINE+=$(need_push)
    fi

    # rootshell gets another prompt sign
    PR_SIGN=$NOCOLOR
    PR_SIGN="%m "
    PR_SIGN+="%F{160}%B"
    PR_SIGN+=%(#."☠".'∴')
    PR_SIGN+="%F{white}%b"

    # Finally, the prompt.
    if [[ ${#VCS_LINE} > 10 ]]; then
        # http://unix.stackexchange.com/questions/1022/is-it-possible-to-display-stuff-below-the-prompt-at-a-prompt
        terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
    	PS1+="%{$terminfo_down_sc$VCS_LINE$terminfo[rc]%}" # the second line
    fi

    PS1+=$PR_SIGN                 # the user sign
    PS1+=" "                      # an additional space
}
add-zsh-hook precmd promptSetup

# remove the line after the prompt on execution
# http://unix.stackexchange.com/questions/1022/is-it-possible-to-display-stuff-below-the-prompt-at-a-prompt
eraseSecondLine () {
    print -rn -- $terminfo[el];
    #echo; # this would keep the second line
}
add-zsh-hook preexec eraseSecondLine

