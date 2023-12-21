#!/usr/bin/env fish
echo "Installing utils..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing brew packages..."
brew install fish
brew install fisher
brew install gh
brew install fzf
brew install ripgrep
brew install lazygit
brew install nnn
brew install pyenv
brew install nvm
brew install node
brew install neovim
brew install skhd
brew install yabai
brew install xcodegen
brew install bat
brew install go
brew install exa
brew install fd

echo "Installing brew casks..."
brew install --cask docker
brew install --cask macgpt
brew install --cask arc
brew install --cask discord
brew install --cask bartender
brew install --cask beeper
brew install --cask daisydisk
brew install --cask font-sf-mono-nerd-font-ligaturized
brew install --cask figma
brew install --cask google-cloud-sdk
brew install --cask keyboardcleantool
brew install --cask kindavim
brew install --cask loom
brew install --cask polypane
brew install --cask ngrok
brew install --cask rapidapi
brew install --cask raycast
brew install --cask sf-symbols
brew install --cask reflect
brew install --cask spaceid
brew install --cask zoom
brew install --cask cleanshot
brew install --cask craft
brew install --cask slack
brew install --cask dash
brew install --cask iina
brew install --cask flux
brew install --cask google-chrome
brew install --cask linear
brew install --cask mullvadvpn
brew install --cask notion
brew install --cask visual-studio-code


echo "Installing dotfiles..."
git clone git@github.com:bmikaili/dotfiles.git

echo "Setup fish..."
sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
chsh -s /opt/homebrew/bin/fish
fish_add_path /opt/homebrew/bin
set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
fisher install
