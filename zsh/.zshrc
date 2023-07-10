export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias emacs="emacsclient -c -a emacs"

alias aup="sudo apt update && sudo apt list --upgradable"
alias aug="sudo apt upgrade"

PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.local/share:/var/home/arneb/.local/share/JetBrains/Toolbox/scripts:/home/linuxbrew/.linuxbrew/bin:$HOME/.local/bin

if [[ -n $container ]]; then export ACCENT="⬢  " ; fi

PROMPT=$ACCENT$PROMPT


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
