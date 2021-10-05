#!/bin/sh
# run from root

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