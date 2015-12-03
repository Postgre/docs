# .bash_profile

# source env variable exported in .profile
if [ -f ~/.profile ]; then
. ~/.profile
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
