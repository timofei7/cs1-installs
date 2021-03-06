#!/bin/bash

BACKUPDIR="/cs1backups"

function error {
  echo "Error occured in $1, please email your TAs with copy/pasted error messages"
  exit 1;
}

function move() {
  suffix=0
  file="$2"
  while test -e "$file"; do
    file="$2.$((suffix++))"
  done
  sudo mv "$1" "$file"
}

OSXVERSION=`sw_vers -productVersion | cut -f1,2 -d.`

echo "this will install homebrew and various cs1 dependencies"
echo "you will see lots of stuff happening but most of it is safe to ignore"
echo "it may take a little while..."
echo ""
echo "authenticating, you may need to enter your system password"
sudo -v

if [[ ! -e /usr/bin/gcc && ! -e /Applications/Xcode.app && ! -e /Developer ]]; then
  echo "no xcode detected please install Xcode first then rerun this"
  exit 1;
else
  echo "xcode detected"
fi

echo "checking xcode agreement"
sudo xcrun echo xcode checks out

echo "backing up possibly conflicting libraries in /opt/local,/usr/local, and /sw"
sudo mkdir $BACKUPDIR
move /opt/local $BACKUPDIR/local.before_CS1 2>&1 | grep -v "No such"
move /usr/local $BACKUPDIR/local.before_CS1 2>&1 | grep -v "No such"
move /opt/homebrew-cask $BACKUPDIR/homebrew-cask.before_CS1 2>&1 | grep -v "No such"
move /sw $BACKUPDIR/sw.before_CS1 2>&1 | grep -v "No such"

echo "fixing /usr/local permissions"
sudo mkdir /usr/local
sudo chflags norestricted /usr/local && sudo chown -R $(whoami):admin /usr/local

echo "installing homebrew from http://mxcl.github.com/homebrew/"
echo "it is an open source package manager, very cool"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || error "installing homebrew"

#echo "testing install"
#DOCTOR=`brew doctor`
#if [[ "$DOCTOR" != *ready\ to\ brew* ]]; then
#  echo "sorry! something went wrong. please copy paste any error messages and email your TAs"
#  echo "error: $DOCTOR"
#  exit 1;
#fi

# echo "reauthenticating if necessary"
# sudo -v

echo "installing python dependency"
brew install python || error "installing python"

echo "installing qt"
brew install qt || error "installing qt"

echo "installing pyqt"
brew install pyqt || error "installing pyqt"

# this is for pycharm
echo "installing ruby"
brew install ruby || error "installing ruby"

# this is for pyside
echo "installing cmake"
brew install cmake || error "installing cmake"

echo "setting paths"
PATH=/usr/local/bin:$PATH
export PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
grep -q '/usr/local/bin' ~/.profile 2>&1 > /dev/null || echo 'export PATH=/usr/local/bin:$PATH' >> ~/.profile
grep -q 'CASK' ~/.profile 2>&1 > /dev/null || echo 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' >> ~/.profile
grep -q '/usr/local/bin' ~/.bashrc 2>&1 > /dev/null || echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bashrc
grep -q 'CASK' ~/.bashrc 2>&1 > /dev/null || echo 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' >> ~/.bashrc

echo "installing pyside dependency, this may take some time"
brew install pyside || error "installing pyside"
brew link --overwrite pyside

#echo "attempting to install pycharm-ce"
#brew install Caskroom/cask/pycharm-ce || error "installing pycharm-ce"

echo "you are all set to go!"
