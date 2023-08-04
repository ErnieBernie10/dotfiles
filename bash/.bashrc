#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# Hishtory Config:
export PATH="$PATH:/home/arneb/.hishtory"
source /home/arneb/.hishtory/config.sh

alias hh="hishtory query"

# Run twolfson/sexy-bash-prompt
. ~/.bash_prompt

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Added by zap installation script
PATH=$PATH:$HOME/.local/bin:$HOME/.local/share/JetBrains/Toolbox/scripts
