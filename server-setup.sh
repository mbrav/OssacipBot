#!/bin/bash
#Linux server setup, tested on ubuntu
#Configures Procesing to run in "headless" mode

echo "Configuring OssacipBot server..."

#Download Processing
wget https://github.com/processing/processing/releases/download/processing-0270-3.5.4/processing-3.5.4-linux64.tgz
tar -xvzf processing-3.5.4-linux64.tgz
rm processing-3.5.4-linux64.tgz

#Install Processing dependencies
mkdir -p ~/sketchbook/libraries/
wget https://github.com/hamoid/video_export_processing/releases/download/v23/VideoExport-23.zip
unzip VideoExport-23.zip -x "**/examples/*" -d ~/sketchbook/libraries/
rm VideoExport-23.zip

#Create a complied executable Processing Applet
./processing-3.5.4/processing-java --sketch=Ossacip --output=node/app --force --export

#Install Xvfb a screen emulater and dependencies
#Needed for displaying Processing apps on computers without screens
sudo apt-get install xvfb libxrender1 libxtst6 libxi6 xorg xvfb dbus-x11 xfonts-100dpi xfonts-75dpi xfonts-cyrillic

#Make the generator script executable
sudo chmod +x node/generate.sh

echo "OssacipBot is set up!"
