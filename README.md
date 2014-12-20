# CS1 OS X Software Installs#






##1) Install Developer Tools + Command Line Tools:##

###on 10.8.x, 10.9.x, and 10.10.x: ###



1. Download and install Xcode via the App Store: [xcode](http://itunes.apple.com/us/app/xcode)
2. Open the Xcode app (/Applications/Xcode.app)
3. Make sure Command Line Tools are installed:
   open /Applications/Terminal.app and run:  `xcode-select --install` like so <br>
![image](https://raw.github.com/timofei7/cs1-installs/master/images/xcode-select.png)
5. Download and install [Xquartz](http://xquartz.macosforge.org/)


##2) Install Homebrew##
###Automatic Installation Method:###
I have a script that will attempt to install everything for you.  There are two versions, one version that compiles everything from scratch and another that downloads prebuilt versions.  If you want to try the automatic method try the first one first and if that fails try the second.

* Prebuilt version: Just open /Applications/Terminal.app and paste in:<br>`bash <(curl -fsSkL raw.github.com/timofei7/cs1-installs/master/install.prepacked.sh)` <br> and follow the prompts.
* Automatic compilation (on non 10.8,10.9,10.10): Just open /Applications/Terminal.app and paste in: <br> `bash <(curl -fsSkL raw.github.com/timofei7/cs1-installs/master/install.sh)` <br>and follow the prompts.


###Manual Installation Method Alternative:###
(do this only if something breaks in the above automatic installations)

####1) Install Homebrew and Dependencies####
1. open the builtin Terminal.app in /Applications (or if you like customization use [iTerm2](http://www.iterm2.com/))
2. backup older/conflicting libraries:
	1. copy/paste into Terminal: `sudo mv /opt/local /opt/local.before_CS1`
	2. copy/paste into Terminal: `sudo mv /usr/local /usr/local.before_CS1`
	3. copy/paste into Terminal: `sudo mv /sw /sw.before_CS10`
3. Install [Homebrew](http://mxcl.github.com/homebrew/) which is a handy opensource sofware manager by just copy/pasting the following into Terminal:  `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
4. Make sure it installed correctly: `brew doctor`
5. It should say: "Your system is ready to brew" if not email any errors you encountered to your TAs

#####2) Install dependencies#####
(copy/paste the following into Terminal.app)

1. Run: `export PATH=/usr/local/bin:$PATH`
2. Run: `echo 'export PATH=/usr/local/bin:$PATH' >> ~/.profile`
2. Run: `brew install python cmake qt pyqt ruby`
3. Run: `brew install pyside`
4. Download  [PyCharm-CE](https://www.jetbrains.com/pycharm/download/)


##3) Configure PyCharm##

1. Launch /Applications/PyCharm CE.app (should already be installed via the automatic)
2. Accept defaults on startup <br>
![image](https://raw.github.com/timofei7/cs1-installs/master/images/pycharm-import.png)
3. Click configure <br>
![image](https://raw.github.com/timofei7/cs1-installs/master/images/pycharm-configure.png)
4. Click preferences <br>
![image](https://raw.github.com/timofei7/cs1-installs/master/images/pycharm-preferences.png)
5. Choose the python interpreter to be: /usr/local/bin/python (in the dropdown) <br>
![image](https://raw.github.com/timofei7/cs1-installs/master/images/pycharm-interpreter.png)


<br>
<hr>

##notes##
