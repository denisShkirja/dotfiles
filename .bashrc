#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias tmux='tmux -2'
PS1='[\u@\h \W]\$ '
