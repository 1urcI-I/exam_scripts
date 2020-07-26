#!/bin/bash

#Setup script for lab network on local/attacking machine
#Create directories for each target ip address

ip=10.10.14.3

echo "Script to create directories for each target"
echo "Begin running script in desired parent directory"
echo "Otherwise, cancel now!!!"

echo "Current directory is: " && pwd
echo "Contents of directory: " && ls
mkdir $ip 
cd $ip
echo "dropping into directory..."

../enumeration_script.sh $ip

pwd

echo "It worked!"

cd ..;

pwd

