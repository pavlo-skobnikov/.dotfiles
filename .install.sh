#!/bin/sh

echo "This script will use git pull to clone some repositories."
echo "So, you should have ssh configured in your GitHub account before running this script."

read -p "Have you run 'xcode-select --install'? 'y' will continue the script" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit
fi
echo

read -p "Have you configured ssh? 'y' will continue the script" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit
fi
echo

# Install Brew
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

## Install SDKMan
echo "Installing SDKMan..."
curl -s "https://get.sdkman.io" | bash

# Install rustup
echo "Installing Rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## Brew taps
echo "Running required brew taps..."
brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae
brew tap koekeishiya/formulae

## Brew formulae and casks
echo "Installing brew formulae and casks..."

echo "Installing general-purpose CLI tools..."
brew install zsh # UNIX shell (command interpreter)
brew install wget # Internet file retriever
brew install coreutils # GNU File, Shell, and Text utilities
brew install gnu-sed # GNU implementation of the famous stream editor
brew install ripgrep # Search tool like grep and The Silver Searcher
brew install fzf # Command-line fuzzy finder written in Go
/opt/homebrew/opt/fzf/install # Install completion and key bindings for fzf
brew install jq # Lightweight and flexible command-line JSON processor
brew install miller # Like sed, awk, cut, join & sort for name-indexed data such as CSV
brew install fd # Simple, fast and user-friendly alternative to find
brew install eza # Modern replacement for `ls`
brew install tree # Display directories as trees (with optional color/HTML output)
brew install rename # Perl-powered file rename script with many helpful built-ins
brew install mas # Mac App Store command-line interface
brew install llvm # Next-gen compiler infrastructure

# Git and CLI tools for remote repositories
echo "Installing git and CLI tools for remote repositories..."
brew install git
brew install gh
brew install glab

# Configure git and clone some repositories
echo "Configuring git default pull strategy and branch name..."
git config --global pull.rebase true
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

echo "Fetching dotfiles..."
git clone --recurse-submodules https://github.com/pavlo-skobnikov/.dotfiles.git ~/.config/

read -p "Download secrets repository? 'y' will download secrets. NOTE: ssh should be already set up!" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Configuring git identifiers..."
  git config --global user.name "Pavlo Skobnikov"
  git config --global user.email "pavlo.skobnikov@gmail.com"

  echo "Fetching secrets..."
  git clone git@github.com:pavlo-skobnikov/.secrets.git ~/.secrets
fi
echo

# Install programming languages and related tools
echo "Installing languages and related tools..."

brew install cmake
brew install cmake-docs
brew install clang-format

brew install zig

brew install rust

brew install lua
brew install luajit
brew install luarocks

sdk install java
sdk install gradle
sdk install maven

brew install clojure
sdk install leiningen # Build automation system
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/weavejester/cljfmt/HEAD/install.sh)"

brew install coursier/formulas/coursier 
cs setup

brew install python3
brew install black

brew install go
go install golang.org/x/tools/cmd/goimports@latest

brew install node
npm completion
brew install typescript

brew install prettier

# Install other tools
echo "Installing other tools..."

echo "Installing tmux and kitty..."
brew install tmux
brew install --cask kitty

echo "Installing code editors..."
brew install neovim
brew install --cask intellij-idea

echo "Installing OS interaction utilities..."
brew install --cask karabiner-elements
brew install --cask hammerspoon

echo "Installing other developer tools..."
brew install --cask docker
brew install --cask postman

echo "Installing messaging and communication tools..."
brew install --cask telegram
brew install --cask slack

echo "Installing the browser..."
brew install --cask google-chrome

echo "Installing the password manager..."
brew install --cask nordpass

echo "Installing the self-management apps..."
brew install --cask notion
brew install --cask notion-calendar
brew install --cask todoist

echo "Installing miscelaneous casks..."
brew install --cask sf-symbols
brew install --cask font-hack-nerd-font

echo "Configuring the environment..."

echo "Making scrips executable..."
chmod -R +x ~/.config/scripts
chmod -R +x ~/.config/scripts/.hidden

echo "Linking some config files..."

# Link tmux config and install TPM
rm -rf ~/.tmux.conf
ln -s ~/.config/tmux/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Link hammerspoon config
rm -rf ~/.hammerspoon  
ln -s ~/.config/hammerspoon ~/.hammerspoon

# Install Zap for Zsh and link .zshrc
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)

rm -f ~/.zshrc
ln -s ~/.config/zsh/.zshrc ~/.zshrc

# Set Zsh as the main system shell
chsh -s $(which zsh)

# macOS Settings
echo "Changing macOS defaults..."
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.spaces spans-displays -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock "mru-spaces" -bool "false"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain _HIHideMenuBar -bool false
defaults write NSGlobalDomain AppleHighlightColor -string "0.65098 0.85490 0.58431"
defaults write NSGlobalDomain AppleAccentColor -int 1
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.Finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowStatusBar -bool false
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Installing Fonts
git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
mv /tmp/SFMono_Nerd_Font/* $HOME/Library/Fonts
rm -rf /tmp/SFMono_Nerd_Font/

# Link IDEAVim config
rm -f ~/.ideavimrc
ln -s ~/.config/idea/.ideavimrc ~/.ideavimrc

echo "Installation complete!"
