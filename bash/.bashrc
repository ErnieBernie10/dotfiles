#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -la'

alias update='sudo apt update && sudo apt list --upgradable'
alias upgrade='sudo apt dist-upgrade'

alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# Hishtory Config:
export PATH="$PATH:/home/arneb/.hishtory"
source /home/arneb/.hishtory/config.sh

alias hh="hishtory query"

# Run twolfson/sexy-bash-prompt
. ~/.bash_prompt

export VOLTA_HOME="$HOME/.volta"
PATH=$PATH:$HOME/.local/bin:$HOME/.local/share/JetBrains/Toolbox/scripts:$VOLTA_HOME/bin
