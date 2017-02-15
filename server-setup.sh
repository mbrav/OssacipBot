#!/bin/bash
#Linux server setup, tested on ubuntu
#Configures Procesing to run in "headless" mode

echo "Configuring OssacipBot server..."

#Download Processing into home folder
cd ~/
echo "Downloading Processing 3 into home directory..."
wget http://download.processing.org/processing-3.3-linux64.tgz
echo "Unpacking Processing..."
tar -xvzf processing-3.3-linux64.tgz
rm processing-3.3-linux64.tgz

#Install Processing dependencies
echo "Installing Processing 3 libraries..."
mkdir -p ~/sketchbook/libraries
git clone https://github.com/01010101/GifAnimation/ ~/sketchbook/libraries/GifAnimation

#Create a complied executable Processing Applet
echo "Creating an executable Processing applet."
~/processing-3.3/processing-java --sketch=Ossacip --output=node/app --force --export

#Install Xvfb a screen emulater and dependencies
#Needed for displaying Processing apps on computers without screens
#sudo apt-get install xvfb libxrender1 libxtst6 libxi6 xorg xvfb dbus-x11 xfonts-100dpi xfonts-75dpi xfonts-cyrillic

#Make the generator script executable
sudo chmod +x OssacipBot/node/generate.sh

echo "OssacipBot is set up!"
