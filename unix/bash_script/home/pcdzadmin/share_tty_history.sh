#! /bin/sh
# =============================================================================
# Allow multiple session to share the same history
# You have to source this shell script on all terminals that participate 
# to the sharing
# ============================================================================

# share history between multiples sessions
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups
# append history entries..
shopt -s histappend
# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

