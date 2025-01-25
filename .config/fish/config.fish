if status is-interactive
    # Commands to run in interactive sessions can go here
end

# fish_add_path ~/.local/share/JetBrains/Toolbox/scripts
# fish_add_path ~/.local/share/JetBrains/Toolbox/apps
# fish_add_path ~/.dotnet/tools
# fish_add_path ~/.config/emacs/bin
# fish_add_path /home/linuxbrew/.linuxbrew/bin
# 
# # bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH

# Aliases
alias box 'distrobox enter'
alias vim nvim
alias v nvim

# Export PATH
set -x PATH $PATH $HOME/.local/bin $HOME/.bin $HOME/.local/share/JetBrains/Toolbox/scripts /usr/local/go/bin $HOME/.dotnet $HOME/.dotnet/tools $HOME/.local/bin/netcoredbg /opt/nvim-linux64/bin /opt/helix $HOME/.local/bin/omnisharp

bind \cy accept-autosuggestion

nvm use lts
