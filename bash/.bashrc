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

export VOLTA_HOME="$HOME/.volta"
PATH=$PATH:$HOME/.local/bin:$HOME/.local/share/JetBrains/Toolbox/scripts:$VOLTA_HOME/bin

reset="\[\e[m\]"
blue="\[\e[00;34m\]"
purple="\[\e[00;35m\]"
cyan="\[\e[00;36m\]"
yellow="\[\e[00;33m\]"
blink_yellow="\[\e[00;33m\]"

first_line="${reset}┌─[${blue}\u${reset}]-[${cyan}\h${reset}]-[${yellow}\w${reset}]"
second_line="\n└─[${blink_yellow}\$${reset}] "

if [ -f /usr/share/git/git-prompt.sh ]; then
    source /usr/share/git/git-prompt.sh
    GIT_PS1_SHOWCOLORHINTS=1
    PROMPT_COMMAND="__git_ps1 '$first_line' '$second_line' ' $purple %s';"
else
    # if the file doesn't exist create prompt directly with PS1
    PS1="$first_line$second_line"
fi
unset reset blue purple cyan yellow blink_yellow first_line second_line
