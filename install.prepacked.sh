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
if [[ $OSXVERSION != "10.8" && $OSXVERSION != "10.9" && $OSXVERSION != "10.10" && $OSXVERSION != "10.11" ]]; then
  echo "running on unsupported version of OS X, only 10.8, 10.9, 10.10, 10.11 are supported"
  exit -1
fi


echo "this will install homebrew and various cs1 dependencies"
echo "you will see lots of stuff happening but most of it is safe to ignore"
echo "it may take a little while..."
echo ""
echo "authenticating, you may need to enter your system password"
sudo -v

if [[ -e /usr/bin/gcc && ! -e /Applications/Xcode.app && ! -e /Developer ]]; then
  echo "detected commandline tools only must enable"
  sudo xcode-select -switch /usr/bin
elif [[ ! -e /usr/bin/gcc && ! -e /Applications/Xcode.app && ! -e /Developer ]]; then
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

echo "installing a prebuilt version of homebrew (http://mxcl.github.com/homebrew/)"
echo "it is an open source package manager, very cool"

cd /usr/
PREPACKAGE=http://www.cs.dartmouth.edu/\~tim/cs1/"$OSXVERSION"_usr.local.tar.gz
echo "downloading and untarring prepacked stuffs from: $PREPACKAGE "
curl $PREPACKAGE | sudo tar -C /usr -zxf -
sudo chown -R $USER /usr/local

echo "setting paths"
PATH=/usr/local/bin:$PATH
export PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
grep -q '/usr/local/bin' ~/.profile 2>&1 > /dev/null || echo 'export PATH=/usr/local/bin:$PATH' >> ~/.profile
grep -q 'CASK' ~/.profile 2>&1 > /dev/null || echo 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' >> ~/.profile
grep -q '/usr/local/bin' ~/.bashrc 2>&1 > /dev/null || echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bashrc
grep -q 'CASK' ~/.bashrc 2>&1 > /dev/null || echo 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' >> ~/.bashrc

#echo "updating packages if necessary..."
#UPDATE=`brew update -q; brew upgrade -q`
#if [[ "$UPDATE" == *rror* ]]; then
#  echo "something went wrong during brew update, this is an optional step but if it worries you email your TAs with this error message"
#  echo "error: $UPDATE"
#fi

#echo "testing install"
#DOCTOR=`brew doctor`

#if [[ "$DOCTOR" != *ready\ to\ brew* && "$DOCTOR" != *Homebrew\ is\ outdated* ]]; then
#  echo "sorry! something went wrong. please copy paste any error messages and email your TAs"
#  echo "if these are warnings about other python versions you may continue and see if it works"
#  echo "error: $DOCTOR"
#fi

# this would automatically install pycharm-ce but looks like some people prefer the download way
#echo "attempting to install pycharm-ce"
#brew install Caskroom/cask/pycharm-ce

echo "you are all set to go!"
