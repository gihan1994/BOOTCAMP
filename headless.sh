#!/bin/bash
#
# Bash script to setup headless Selenium (uses Xvfb and Chrome)
# (Tested on Ubuntu 12.04) trying on ubuntu server 14.04

# Add Google Chrome's repo to sources.list
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee -a /etc/apt/sources.list

# Install Google's public key used for signing packages (e.g. Chrome)
# (Source: http://www.google.com/linuxrepositories/)
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo yum add -

# Update apt sources:
sudo yum update

# Install Python, pip, Selenium:
#sudo yum -y install python python-pip
#sudo pip install selenium
different way to get chromedriver and selenium java jar:
sudo yum -y install default-jre  # if not installed yet
sudo npm install protractor -g
sudo webdriver-manager update
sudo ln /usr/lib/node_modules/protractor/selenium/chromedriver /usr/bin/chromedriver
#sudo yum -y install unzip
# Download/Install chromedriver
# (http://code.google.com/p/chromedriver/):
#
# For x86:
#wget -c http://chromedriver.googlecode.com/files/chromedriver_linux32_2.1.zip
#unzip chromedriver_linux32_2.1.zip
#
# For x86-64:
#wget -c http://chromedriver.googlecode.com/files/chromedriver_linux64_2.1.zip
#unzip chromedriver_linux64_2.1.zip
# Neither creating symbolic link nor adding dir to $PATH worked for me
# in a Vagrant VM. So, let's blatantly copy the binary:
#sudo cp ./chromedriver /usr/bin/
#sudo chmod ugo+rx /usr/bin/chromedriver

# Install Google Chrome:
sudo yum install libxpm4 libxrender1 libgtk2.0-0 libnss3 libgconf-2-4
sudo yum -y install google-chrome-stable

# Dependencies to make "headless" chrome/selenium work:
sudo yum -y install xvfb gtk2-engines-pixbuf
sudo yum -y install xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable

# Optional but nifty: For capturing screenshots of Xvfb display:
sudo yum -y install imagemagick x11-apps

# Make sure that Xvfb starts everytime the box/vm is booted:
echo "Starting X virtual framebuffer (Xvfb) in background..."
Xvfb -ac :99 -screen 0 1280x1024x16 &
export DISPLAY=:99

# Optionally, capture screenshots using the command:
#xwd -root -display :99 | convert xwd:- screenshot.png
