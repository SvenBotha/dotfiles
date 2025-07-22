#!/bin/zsh

set -e  # Exit on error

# --------------------------
# Install Homebrew
# --------------------------
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed"
fi

# --------------------------
# Install helper function
# --------------------------
install_if_missing() {
  local pkg=$1
  local is_cask=$2

  if [[ "$is_cask" == "cask" ]]; then
    if brew list --cask | grep -q "^$pkg\$"; then
      echo "📦 $pkg (cask) already installed"
    else
      echo "📥 Installing $pkg (cask)..."
      brew install --cask "$pkg"
    fi
  else
    if brew list --formula | grep -q "^$pkg\$"; then
      echo "📦 $pkg already installed"
    else
      echo "📥 Installing $pkg..."
      brew install "$pkg"
    fi
  fi
}

# --------------------------
# CLI Tools
# --------------------------
install_if_missing git
install_if_missing zsh
install_if_missing tmux
install_if_missing neovim
install_if_missing fzf
install_if_missing bash

# --------------------------
# CLI Tools
# --------------------------
install_if_missing lazygit


# --------------------------
# GUI Apps
# --------------------------
install_if_missing firefox cask
install_if_missing visual-studio-code cask
install_if_missing microsoft-teams cask
install_if_missing wezterm cask

# --------------------------
# Fonts
# --------------------------
install_if_missing font-meslo-lg-nerd-font

# --------------------------
# ZSH Plugins & Theme
# --------------------------
install_if_missing powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc

install_if_missing zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

install_if_missing zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

# --------------------------
# WezTerm
# --------------------------
touch ~/.wezterm.lua

# --------------------------
# Tmux & Config
# --------------------------
curl -fsSL https://raw.githubusercontent.com/josean-dev/dev-environment-files/main/.tmux.conf -o ~/.tmux.conf

if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Reload Tmux config if in a session
if pgrep -x tmux >/dev/null; then
  tmux source ~/.tmux.conf
fi

# --------------------------
# Copy dotfiles (assuming dotfiles repo is cloned already)
# --------------------------
echo "🔗 Copying dotfiles..."
ß
DOTFILES_DIR="."  # Change if your dotfiles repo is elsewhere

cp -v "$DOTFILES_DIR/zshrc/zshrc" ~/.zshrc
cp -v "$DOTFILES_DIR/wezTerm/wezterm.lua" ~/.wezterm.lua
cp -v "$DOTFILES_DIR/aeroSpace/aerospace.toml" ~/.aerospace.toml
cp -v "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf


# Add any other config files here
# cp -v "$DOTFILES_DIR/.gitconfig" ~/

echo "✅ Setup complete! Restart terminal or source ~/.zshrc"
    