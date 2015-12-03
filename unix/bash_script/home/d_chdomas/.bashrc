# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

export PS1='\[\033[01;33m\]\u@${HOSTNAME%%.*} \[\033[01;34m\]\w $ \[\033[00m\]'

# User specific aliases and functions
alias h='history'
alias madev='sudo -i -u madev'
alias panama='sudo -i -u panama' 

alias h='history'
alias ll='ls -l'
alias la='ls -lart'
