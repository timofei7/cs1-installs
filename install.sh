#!/bin/bash

function error {
  echo "Error occured in $1, please email your TAs with copy/pasted error messages"
  exit 1;
}


OSXVERSION=`sw_vers -productVersion | cut -f1,2 -d.`

echo "this will install homebrew and various cs1 dependencies"
echo "you will see lots of stuff happening but most of it is safe to ignore"
echo "it may take a little while..."
echo ""
echo "authenticating, you may need to enter your system password"
sudo -v

# if [[ -e /usr/bin/gcc && ! -e /Applications/Xcode.app && ! -e /Developer ]]; then
#   echo "detected commandline tools only must enable"
#   sudo xcode-select -switch /usr/bin
if [[ ! -e /usr/bin/gcc && ! -e /Applications/Xcode.app && ! -e /Developer ]]; then
  echo "no xcode detected please install Xcode first then rerun this"
  exit 1;
else
  echo "xcode detected"
fi

echo "backing up possibly conflicting libraries in /opt/local,/usr/local, and /sw"
sudo mv /opt/local /opt/local.before_CS1 2>&1 | grep -v "No such"
sudo mv /usr/local /usr/local.before_CS1 2>&1 | grep -v "No such"
sudo mv /sw /sw.before_CS1 2>&1 | grep -v "No such"

echo "installing homebrew from http://mxcl.github.com/homebrew/"
echo "it is an open source package manager, very cool"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || error "installing homebrew"

DOCTOR=`brew doctor`

if [[ "$DOCTOR" != *raring\ to\ brew* ]]; then
  echo "sorry! something went wrong. please copy paste any error messages and email your TAs"
  echo "error: $DOCTOR"
  exit 1;
fi

echo "reauthenticating if necessary"
sudo -v

echo "installing python dependency"
brew install python || error "installing python"

echo "installing qt"
brew install qt || error "installing qt"

echo "installing pyqt"
brew install pyqt || error "installing pyqt"

echo "setting paths"
PATH=/usr/local/bin:/usr/local/share/python:$PATH
export PATH
echo 'export PATH=/usr/local/bin:/usr/local/share/python:$PATH' >> ~/.profile

echo "installing pyside dependency"
/usr/local/share/python/pip -q install pyside || error "installing pyside"

echo "you are all set to go!"
