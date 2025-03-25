#!/bin/bash

# variables
installation_path="/home/ubuntu"
platform="linux_x64"
cx_binary_link="https://github.com/Checkmarx/ast-cli/releases/download/2.3.17/ast-cli_${platform}.tar.gz"

# update the server
sudo apt-get update

# install binary
wget -P $installation_path $cx_binary_link

# untar the binary .gz tar
tar -xzvf "$installation_path/ast-cli_${platform}.tar.gz"

# remove unnecessary tar archive
rm "$installation_path/$ast-cli_${platform}.tar.gz"

#add binary to a path variable
#export $PATH="$PATH:/home/ubuntu/cx"
