#!/bin/bash
#Linux server setup, tested on ubuntu
#Configures Procesing to run in "headless" mode

echo "Configuring OssacipBot server..."

#Download Processing
echo "Downloading Processing 3 into home directory..."
wget https://github.com/processing/processing/releases/download/processing-0270-3.5.4/processing-3.5.4-linux64.tgz

echo "Unpacking Processing..."
tar -xvzf processing-3.5.4-linux64.tgz
rm processing-3.5.4-linux64.tgz

#Install Processing dependencies
echo "Installing Processing 3 libraries..."
mkdir -p ~/sketchbook/libraries/
wget https://github.com/hamoid/video_export_processing/releases/download/v23/VideoExport-23.zip
unzip VideoExport-23.zip -x "**/examples/*" -d ~/sketchbook/libraries/
rm VideoExport-23.zip

#Create a complied executable Processing Applet
echo "Creating an executable Processing applet."
./processing-3.5.4/processing-java --sketch=Ossacip --output=bot/app --force --export

#Install Xvfb a screen emulater and dependencies
#Needed for displaying Processing apps on computers without screens
sudo apt-get install xvfb libxrender1 libxtst6 libxi6 default-jre

#Make the generator script executable
sudo chmod +x bot/generate.sh

echo "OssacipBot is set up!"
