#!/bin/bash

set -e

echo "==> Installing oh-my-posh..."
if ! command -v oh-my-posh &> /dev/null; then
  curl -s https://ohmyposh.dev/install.sh | bash -s
else
  echo "oh-my-posh is already installed"
fi

echo "==> Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" -y

# Optional: source .bashrc (only affects current script shell)
echo "==> Sourcing .bashrc..."
source "$HOME/.bashrc"

echo "==> Installing brew tools..."
/home/linuxbrew/.linuxbrew/bin/brew install go
/home/linuxbrew/.linuxbrew/bin/brew install fzf
/home/linuxbrew/.linuxbrew/bin/brew install fabric-ai
/home/linuxbrew/.linuxbrew/bin/brew install eza
/home/linuxbrew/.linuxbrew/bin/brew install zoxide
/home/linuxbrew/.linuxbrew/bin/brew install helix
/home/linuxbrew/.linuxbrew/bin/brew install age
/home/linuxbrew/.linuxbrew/bin/brew install stow

rm ~/.bashrc
rm ~/.zshrc

/home/linuxbrew/.linuxbrew/bin/stow .

echo "✅ Done!"
