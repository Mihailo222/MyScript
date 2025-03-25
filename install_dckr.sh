#!/bin/bash

# variables defined

packages_to_uninstall=( "docker.io" "docker-compose" "docker-compose-v2" "docker-doc" "podman-docker" )
latest_version_packages=( "docker-ce" "docker-ce-cli" "containerd.io" "docker-buildx-plugin" "docker-compose-plugin" )

# check if you run a script with sudo priviledges

if [ $(id -u) -ne 0 ]
then
  echo "This script needs root priviledges for execution."
  exit 1
fi


# uninstall any conflicting packages

for pkg in $packages_to_uninstall;
  do
    echo "Removing package $pkg ..."
    sudo apt-get remove $pkg
    echo "Package $pkg removed."
  done


# set up Docker's apt repository


sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings # install -m, -d; -m is mode; -d is directory

# curl docker gpg keys into folder /etc/apt/keyrings/docker.asc
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
#-f = fail silently, if an error occurs, no output is produced
#-s = silent mode, hide progress bar and error messages
#-S = show error message if smth goes wrong ( even -s is set )
#-L = follow HTTP 3xx redirects; ensure the final destination URL is accessed


# add the repository to Apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# update the server
sudo apt-get update


# install following packages
for pkg in $latest_version_packages
  do
    sudo apt-get install $pkg
  done


#check docker version
docker -v
