#!/bin/bash

target() {
  rand=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 5 | head -n 1)
  read -p "What host/IP do you want to ping?: " target1
  echo "You want toi ping: $target1"
  echo >> $PWD/config.d/Targets
  echo -e "++ $rand" >> $PWD/config.d/Targets
  echo >> $PWD/config.d/Targets
  echo "menu = $target1" >> $PWD/config.d/Targets
  echo "title = $target1" >> $PWD/config.d/Targets
  echo "host = $target1" >> $PWD/config.d/Targets
  echo >> $PWD/config.d/Targets
  read -p "Do you want to add any more targets? (y/n) " answer
}

echo
echo  "This script will customise and then build a new Smokeping container"
echo
sleep 1
echo  "Applying customisation..."
echo
target
  while [ $answer == "y" ]; do
    target
  done
echo 
echo "Updating $PWD/config.d/Targets..."
sleep 1
echo "...done!"
sleep 1
echo "Building image..."
docker build -t smokeping .
echo 
sleep 1
read -p "Image built, what do you want to call the container?: " containerName
read -p "What port do you want to access Smokeping on?: " port
docker run -d -p $port:80 --name $containerName --rm smokeping
echo
echo "Container is running, access from your host on: 
http://dockerHostIP/smokeping/smokeping.cgi"
