# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions
alias h='history'
alias tools='cd /export/tools'
alias apps='cd /export/apps'
alias iam='cd /export/apps/iamapi-server'
alias mysql='mysql --user=madev --password=madev'
