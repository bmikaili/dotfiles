#!/bin/bash
echo "Installing utils..."
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(
  echo
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
) >>/Users/bmikaili/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Install Rust..."
curl https://sh.rustup.rs -sSf | sh -s -- -y

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
brew install xcodegen
brew install bat
brew install go
brew install eza
brew install fd
brew install mas
brew install clx
brew install 1password
brew install 1password-cli
brew install sox
brew install atuin
brew install git-delta
brew install xh
brew install sd
brew install ghostscript
brew install qpdf
brew install vldmrkl/formulae/airdrop-cli
brew tap FelixKratz/formulae
brew install svim
brew install zoxide

echo "Installing brew casks..."
brew install --cask docker
brew install --cask arc
brew install --cask discord
brew install --cask bartender
brew install --cask daisydisk
brew install --cask font-sf-mono-nerd-font-ligaturized
brew install --cask figma
brew install --cask google-cloud-sdk
brew install --cask keyboardcleantool
brew install --cask loom
brew install --cask wezterm
brew install --cask rapidapi
brew install --cask raycast
brew install --cask sf-symbols
brew install --cask spaceid
brew install --cask zoom
brew install --cask cleanshot
brew install --cask slack
brew install --cask iina
brew install --cask flux
brew install --cask google-chrome
brew install --cask linear
brew install --cask visual-studio-code
brew install --cask things
brew install --cask mullvadvpn
brew install --cask itsycal
brew install --cask nikitabobko/tap/aerospace
brew install --cask homerow
brew install --cask meetingbar
brew install --cask lookaway
brew install --cask hyperkey
brew install --cask cursor

echo "Installing App Store apps..."
mas install 1136220934 # Infuse
mas install 1091189122 # Bear

echo "Installing dotfiles..."
git clone git@github.com:bmikaili/dotfiles.git

echo "Setup fish..."
sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
chsh -s /opt/homebrew/bin/fish
fish_add_path /opt/homebrew/bin
set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
fisher install

echo "Setup Xcode"
git clone https://github.com/SolaWing/xcode-build-server.git
sudo ln -s ~/xcode-build-server /usr/local/bin

echo "Setup macos..."
# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Run the screensaver if we're in the bottom-left hot corner.
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Hide Safari's bookmark bar.
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
