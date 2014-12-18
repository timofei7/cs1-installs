# CS1 OS X Software Installs#






##1) Install Developer Tools + Command Line Tools:##

###on 10.9.x and 10.10.x: ###



1. Download and install Xcode via the App Store: [xcode](http://itunes.apple.com/us/app/xcode)
2. Open the Xcode app (/Applications/Xcode.app)
3. Make sure Command Line Tools are installed:
   open /Applications/Terminal.app and run:  `xcode-select --install` like so
![image](https://raw.github.com/timofei7/cs1-installs/master/images/xcode-select.png)
<!--5. Download and install [Xquartz](http://xquartz.macosforge.org/)-->


##2) Install Homebrew##
###Automatic Installation Method:###
I have a script that will attempt to install everything for you.  There are two versions, one version that compiles everything from scratch and another that downloads prebuilt versions.  If you want to try the automatic method try the first one first and if that fails try the second.
 
* Automatic compilation: Just open /Applications/Terminal.app and paste in: `bash <(curl -fsSkL raw.github.com/timofei7/cs1-installs/master/install.sh)` and follow the prompts. 
* Faster Prebuilt alternative: Just open /Applications/Terminal.app and paste in:  `bash <(curl -fsSkL raw.github.com/timofei7/cs1-installs/master/install.prepacked.sh)` and follow the prompts.


###Manual Installation Method Alternative:###

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

1. Run: `export PATH=/usr/local/bin:$PATH`
2. Run: `brew install python cmake qt pyqt`
3. Run: `/usr/local/bin/pip -q install pyside`


<!--##3) Configure eclipse project##

2. Download [JavaCV](http://javacv.googlecode.com/files/javacv-0.2-bin.zip), unzip, put it into some folder that you can remember.
3. Start eclipse and open your java project
4. Navigate to Project > Properties > Java Build Path > Libraries and click "Add External JARs...".
4. Locate the JAR files, select them, and click OK.-->

<br>
<hr>

##notes##











