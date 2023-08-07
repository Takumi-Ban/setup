#!/bin/sh

# Ask password for admin
echo "Please enter your password for admin"
sudo -v

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
touch ~/.zshrc
echo '# Homebrew' >> ~/.zshrc
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
echo "Successfully installed Homebrew!"

# Install Homebrew packages
echo "Installing Homebrew packages..."
brew install git
brew install htop
brew install wget
brew install postgresql
brew install node
brew install pyenv
brew install marp-cli
echo "Successfully installed Homebrew packages!"

# Install Homebrew casks
echo "Installing Homebrew casks..."
brew install --cask brave-browser
brew install --cask discord
brew install --cask docker
brew install --cask font-jetbrains-mono
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask github
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask google-japanese-ime
brew install --cask hyper
brew install --cask karabiner-elements
brew install --cask microsoft-edge
brew install --cask microsoft-excel
brew install --cask microsoft-powerpoint
brew install --cask microsoft-word
brew install --cask microsoft-teams
brew install --cask notion
brew install --cask obs
brew install --cask onedrive
brew install --cask raspberry-pi-imager
brew install --cask slack
brew install --cask visual-studio-code
brew install --cask zoom
echo "Successfully installed Homebrew casks!"

# setup pyenv
echo "Setting up pyenv..."
echo '# Pyenv' >> ~/.zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# reflrct changes
echo "Reflrcting changes..."
source ~/.zshrc
echo "Successfully reflrcted changes!"

# Install Python
echo "Installing Python with Pyenv..."
pyenv install 3.9.13
pyenv global 3.9.13
echo "Successfully installed Python with pyenv!"

# write to .zshrc
echo "Writing to .zshrc..."

cat <<EOS >> ~/.zshrc
# shell
ARCH=`uname -m`
PROMPT="
%F{green}${ARCH}%f:%F{blue}%~%f
%F{magenta}❯%f "

# alias
alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -laG"
alias slp="pmset sleepnow"
alias cdg="cd Google\ Drive/My\ Drive/"
alias rm="trash -F"
alias swa="switch-arch()"
alias w='() { curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Tokyo}" }'
alias reshell='exec $SHELL -l'
EOS

echo "Successfully wrote to .zshrc!"

# reflrct changes
echo "Reflrcting changes..."
source ~/.zshrc
echo "Successfully reflrcted changes!"

# setup System Preferences
echo "Setting up System Preferences..."
## Dock
## Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Magnificate the Dock
defaults write com.apple.dock magnification -bool true
## Set the icon size of Dock items to 40 pixels
defaults write com.apple.dock tilesize -int 40
## Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"
## Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true
## Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true
## Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
## Hot corners
### Possible values:
###  0: no-op
###  2: Mission Control
###  3: Show application windows
###  4: Desktop
###  5: Start screen saver
###  6: Disable screen saver
###  7: Dashboard
### 10: Put display to sleep
### 11: Launchpad
### 12: Notification Center
### Top left screen corner → Put Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Notification Center
defaults write com.apple.dock wvous-bl-corner -int 12
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner → Mission Control
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0

# Restart Dock
killall Dock
echo "Refreshing Dock..."
sleep 3

## Finder
## Set `${HOME}` as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
# Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
# Show Tab bar in Finder
defaults write com.apple.finder ShowTabView -bool true
# Show the ~/Library directory
chflags nohidden ~/Library
# Show the hidden files 
defaults write com.apple.finder AppleShowAllFiles YES
# Show the file extensions
defaults write -g AppleShowAllExtensions -bool true
# Show the full path in the title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Show the item info near the icons
defaults write com.apple.finder ShowItemInfo -bool true
# disable create .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

## Restart Finder
killall Finder
echo "Refreshing Finder..."

## UI
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "
# battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
# clock format
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm:ss"
# display items
defaults write com.apple.systemuiserver menuExtras -array \
"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
"/System/Library/CoreServices/Menu Extras/Battery.menu" \
"/System/Library/CoreServices/Menu Extras/Clock.menu" \
"/System/Library/CoreServices/Menu Extras/Displays.menu" \
"/System/Library/CoreServices/Menu Extras/Volume.menu"

## Restart SystemUIServer
killall SystemUIServer
echo "Refreshing SystemUIServer..."
sleep 3

# set default browser
echo "Setting default browser..."
open -a "Google Chrome" --args --make-default-browser
echo "Successfully set default browser!"

# upgrade quality of Bluetooth audio
echo "Upgrading quality of Bluetooth audio..."
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40ss
echo "Successfully upgraded quality of Bluetooth audio!"

echo "Successfully set up System Preferences!"
sleep 3

echo "Setting up is completed!"
echo "Please restart your Mac to apply all settings.Automatically restart in 10 seconds..."
sleep 10
sudo shutdown -r now