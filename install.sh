#!/bin/bash

set -e

echo "==> Installing oh-my-posh..."
if ! command -v oh-my-posh &> /dev/null; then
  curl -s https://ohmyposh.dev/install.sh | bash -s
else
  echo "oh-my-posh is already installed"
fi

echo "==> Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Optional: source .bashrc (only affects current script shell)
echo "==> Sourcing .bashrc..."
source "$HOME/.bashrc"

echo "==> Installing brew tools..."
brew install go
brew install fzf
brew install fabric-ai

echo "✅ Done!"
