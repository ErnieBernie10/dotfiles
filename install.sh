mkdir -p ~/.config/tmux

wget -qO- https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz | tar -xz -C ~/.bin && echo "Zellij has been successfully installed to ~/.bin"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/marlonrichert/zsh-autocomplete ~/.zsh/plugins/zsh-autocomplete

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

systemctl --user daemon-reload

systemctl --user start backup_timer.timer
systemctl --user enable backup_timer.timer

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
