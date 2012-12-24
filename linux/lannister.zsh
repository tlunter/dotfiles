if [[ `uname -n` == 'lannister' ]]; then
    WORKON_HOME=~/Envs
    PROJECT_HOME=~/Projects/Python
    source /usr/local/bin/virtualenvwrapper.sh

    PATH=$PATH:$HOME/.rvm/bin:./lib/tasks # Add RVM to PATH for scripting
fi
