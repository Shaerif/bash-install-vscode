#!/bin/sh
# run from root or with sudo

# 1: Get snap if not automatically installed on Ubuntu

MINVER=16
CURVER=$(lsb_release -rs | grep -o -E '[0-9]+\.' | grep -o -E '[0-9]+')

if [ $CURVER -ge $MINVER ];
then
    echo "Ubuntu version >= 16.04. No need to install snap" 
else
    echo "Ubuntu version < 16.04. Trying to install snap..."
    apt update
    apt install snapd -y
fi

# 2: Install Visual Studio Code with snap

snap install --classic code