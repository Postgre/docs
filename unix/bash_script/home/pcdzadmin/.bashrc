# .bashrc
# =============================================================================
# Put interactive options in this file
# PATHs and HOMEs must be set in .profile
# =============================================================================
# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# -----------------------------------------------------------------------------
# git 
# -----------------------------------------------------------------------------
# configure git prompt
export GIT_PS1_SHOWUPSTREAM="auto verbose"
export GIT_PS1_SHOWDIRTYSTATE="yes"
export GIT_PS1_SHOWSTASHSTATE="yes"
export GIT_PS1_SHOWUNTRACKEDFILES="yes"

# source git completion (and git prompt)
source ~/.local/bin/git-completion.sh


# -----------------------------------------------------------------------------
# prompt
# -----------------------------------------------------------------------------
# change prompt
# old PS1="\\[\\033[01;33m\\]\\u@\\h \\[\\033[01;34m\\]\\w $ \\[\\033[00m\\]"
PS1="\\[\\033[01;33m\\]\\u@\\h \\[\\033[01;34m\\]\\w$(__git_ps1) \\[\\033[00m\\]"


# -----------------------------------------------------------------------------
# xmllint
# -----------------------------------------------------------------------------
export XMLLINT_INDENT="   " 


# -----------------------------------------------------------------------------
# alias
# -----------------------------------------------------------------------------
alias h='history'
alias la='ls -al'

alias glog='git log --graph | less -R'

alias apps='cd /slpafrcdz0001/apps/'
alias dew='cd /slpafrcdz0001/apps/dew'

alias gotrac='cd /slpafrcdz0001/apps/dew/trac'
alias got=gotrac

alias gogit='cd /slpafrcdz0001/apps/dew/git'
alias gog=gogit

alias gosvn='cd /slpafrcdz0001/apps/dew/svn'
alias gos=gosvn

alias goxwiki='cd /slpafrcdz0001/apps/dew/xwiki'
alias gox=goxwiki

alias godist='cd /slpafrcdz0001/apps/dew/dist/workspace'
alias god=godist

alias gonode='cd /slpafrcdz0001/apps/dew/nodejs'
alias gon=gonode
