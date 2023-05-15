#!/bin/sh

echo "This script will use git pull to clone some repositories."
echo "So, you should have ssh configured in your GitHub account before running this script."

read -p "Have you configured ssh? 'y' will continue the script" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit
fi
echo

# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

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

## Brew formulae
echo "Installing brew formulae..."
brew install zsh
brew install wget
brew install coreutils
brew install gnu-sed
brew install xclip
brew install ripgrep
brew install fzf
brew install jq
brew install fd
brew install exa
brew install tree
brew install rename
brew install neofetch
brew install mas

brew install git
brew install gh
brew install glab

brew install svim

brew install neovim

brew install npm

## Brew casks
echo "Installing brew casks..."
brew install --cask amethyst
brew install --cask alfred
brew install --cask sf-symbols
brew install --cask font-hack-nerd-font

brew install --cask libreoffice
brew install --cask kitty

brew install --cask zoom
brew install --cask telegram
brew install --cask slack

brew install --cask docker
brew install --cask intellij-idea
brew install --cask postman

brew install --cask notion
brew install --cask nordpass
brew install --cask google-chrome

# Install npm packages
echo "Installing npm packages..."
npm install -g npm-groovy-lint

# Configure git and clone some repositories
echo "Configuring git default pull strategy and branch name..."
git config --global pull.rebase true
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

echo "Are you Pavlo Skobnikov? If not, then press anything anything but 'y'!"

read -p "Download secrets repository? 'y' will download secrets." -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Configuring git identifiers..."
  git config --global user.name "Pavlo Skobnikov"
  git config --global user.email "pavlo.skobnikov@gmail.com"

  echo "Fetching secrets..."
  git clone https://github.com/pavlo-skobnikov/secrets.git ~/secrets
fi
echo

echo "Fetching dotfiles..."
git clone https://github.com/pavlo-skobnikov/dotfiles.git ~/dotfiles

# Link dotfiles
echo "Linking .config folder from dotfiles..."
ln -s ~/dotfiles ~/.config

ln -s ~/dotfiles/amethyst/.amethyst.yml ~/.amethyst.yml

# Install Zap for Zsh and link .zshrc
echo "Installing Zsh and linking .zshrc..."
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)

rm -f ~/.zshrc
ln -s ~/dotfiles/.zshrc ~/.zshrc

# Set Zsh as the main system shell
echo "Setting Zsh as the main system shell..."
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

curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# Configure Eclipse JDTLS for Java nvim development because it's a pain in the ass >:(
echo "Installing basic Java tools..."
sdk install java
sdk install gradle
sdk install maven

# Install and build LSP extensions
echo "Setting up and building JDTLS Extensions"

# Remove target directory and recreate it (for script re-runs)
# The JDTLS itself will be installed by the NeoVim LSP manager
rm -rf ~/.local/source/java_lsp_extensions
mkdir -p ~/.local/source/java_lsp_extensions

# Java Debug
echo "Building JDTLS debugging extension..."
git clone https://github.com/microsoft/java-debug.git ~/.local/source/java_lsp_extensions/java-debug
( cd ~/.local/source/java_lsp_extensions/java-debug ; ./mvnw clean install -DskipTests )

# Java Testing
echo "Building JDTLS test running extension..."
git clone https://github.com/microsoft/vscode-java-test ~/.local/source/java_lsp_extensions/vscode-java-test
( cd ~/.local/source/java_lsp_extensions/vscode-java-test ; npm install ; npm run build-plugin )

# Java Decompiler
echo "Building JDTLS decompiler extension..."
git clone https://github.com/microsoft/vscode-java-test ~/.local/source/java_lsp_extensions/vscode-java-test
git clone https://github.com/dgileadi/vscode-java-decompiler ~/.local/source/java_lsp_extensions/vscode-java-decompiler

# Configure IntelliJ
echo "Linking IntelliJ .ideavimrc..."
rm -f ~/.ideavimrc

ln -s ~/dotfiles/.ideavimrc ~/.ideavimrc

# Start Services
echo "Starting Services (grant permissions)..."
brew services start svim

echo "Installation complete!"
