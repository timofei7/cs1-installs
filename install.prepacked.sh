#!/bin/bash

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
if [[ $OSXVERSION != "10.10" && $OSXVERSION != "10.9" ]]; then
  echo "running on unsupported version of OS X, only 10.9 and 10.10 are supported"
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
move /opt/local /opt/local.before_CS1 2>&1 | grep -v "No such"
move /usr/local /usr/local.before_CS1 2>&1 | grep -v "No such"
move /sw /sw.before_CS1 2>&1 | grep -v "No such"

echo "installing a prebuilt version of homebrew (http://mxcl.github.com/homebrew/)"
echo "it is an open source package manager, very cool"

cd /usr/
PREPACKAGE=http://www.cs.dartmouth.edu/\~tim/cs1/"$OSXVERSION"_usr.local.tar.gz
echo "downloading and untarring prepacked stuffs from: $PREPACKAGE "
curl $PREPACKAGE | sudo tar -C /usr -zxf -

echo "setting paths"
PATH=/usr/local/bin:$PATH
export PATH
grep -q '/usr/local/bin' ~/.profile 2>&1 > /dev/null || echo 'export PATH=/usr/local/bin:$PATH' >> ~/.profile

echo "testing install"
DOCTOR=`brew doctor`

if [[ "$DOCTOR" != *ready\ to\ brew* && "$DOCTOR" != *Homebrew\ is\ outdated* ]]; then
  echo "sorry! something went wrong. please copy paste any error messages and email your TAs"
  echo "error: $DOCTOR"
  exit 1;
fi

echo "updating packages if necessary..."
UPDATE=`brew update; brew upgrade`
if [[ "$UPDATE" == *rror* ]]; then
  echo "something went wrong during brew update, this is an optional step but if it worries you email your TAs with this error message"
  echo "error: $UPDATE"
  exit 1;
fi

echo "you are all set to go!"
