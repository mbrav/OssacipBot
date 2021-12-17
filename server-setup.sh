#!/bin/bash
#Linux server setup, tested on ubuntu
#Configures Procesing to run in "headless" mode

echo "Configuring OssacipBot server..."
url="https://github.com/processing/processing/releases/download/processing-0270-3.5.4/processing-3.5.4-linux64.tgz"
tar_file="processing.tgz"
folder="./processing"
processing="${folder}/processing-java"
lib_path="${folder}/sketchbook/libraries/"

app_export_path="bot/app"

echo "Downloading Processing 3 into home directory..."
wget $url -O $tar_file

echo "Unpacking Processing..."
mkdir $folder
tar -xvzf $tar_file -C $folder --strip-components=1
rm $tar_file 

echo "Installing Processing 3 libraries..."
mkdir -p $lib_path
wget https://github.com/hamoid/video_export_processing/releases/download/v23/VideoExport-23.zip
unzip VideoExport-23.zip -x "**/examples/*" -d $lib_path
rm VideoExport-23.zip


echo "Creating an executable Processing applet."
$processing --sketch=Ossacip --output=$app_export_path --force --export

# #Install Xvfb a screen emulater and dependencies
# #Needed for displaying Processing apps on computers without screens
# sudo apt-get install xvfb libxrender1 libxtst6 libxi6 default-jre

# #Make the generator script executable
# sudo chmod +x bot/generate.sh

echo "OssacipBot is set up!"
