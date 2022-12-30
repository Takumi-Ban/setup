#!/bin/sh

# Ask password for admin
echo "Please enter your password for admin"
sudo -v

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
touch ~/.zshrc
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
echo "Successfully installed Homebrew!"

# Install Homebrew packages
echo "Installing Homebrew packages..."
brew install git
brew install htop
brew install wget
brew install zsh
brew install postgresql
brew install mysql@5.7
brew install node
brew install ncurses
brew install nginx
brew install openssl@1.1
brew install pcre2
brew install phpmyadmin
brew install tcl-tk
brew install protobuf
brew install pyenv
brew install pipenv
brew install mas
echo "Successfully installed Homebrew packages!"

# Install Homebrew casks
echo "Installing Homebrew casks..."
brew install --cask google-chrome
brew install --cask visual-studio-code
# brew install --cask iterm2
brew install --cask docker
brew install --cask slack
# brew install --cask spotify
brew install --cask zoom
brew install --cask discord
brew install --cask hyper
brew install --cask google-drive
brew install --cask microsoft-word
brew install --cask microsoft-excel
brew install --cask microsoft-powerpoint
brew install --cask onedrive
brew install --cask musescore
brew install --cask cyberduck
brew install --cask amazon-music
brew install --cask kindle
brew install --cask unity-hub
brew install --cask notion
echo "Successfully installed Homebrew casks!"

# Install mas
echo "Installing App Store apps..."
echo "Login your Apple ID"
mas signin

mas install 441258766 # Magnet
# mas install 409183694 # Keynote
# mas install 409201541 # Pages
# mas install 409203825 # Numbers
mas install 497799835 # Xcode
mas install 539883307 # LINE
mas install 405843582 # Alfred
echo "Successfully installed App Store apps!"

# setup pyenv
echo "Setting up pyenv..."
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

setopt share_history
autoload -Uz colors ; colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# (for M1) ARM / x86 Switcher
switch-arch() {
    if  [[ "$(uname -m)" == arm64 ]]; then
       arch=x86_64
    elif [[ "$(uname -m)" == x86_64 ]]; then
       arch=arm64e
    fi
    exec arch -arch $arch "$SHELL"
}

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

# Hyper Config
# Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
# Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
# Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
# Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

# Show cwd when shell prompts for input.
precmd() {
   if overridden; then return; fi
   cwd=${$(pwd)##*/} # Extract current working dir only
   print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}

# Prepend command (w/o arguments) to cwd while waiting for command to complete.
preexec() {
   if overridden; then return; fi
   printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}
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