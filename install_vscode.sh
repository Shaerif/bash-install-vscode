#!/bin/sh
# Claire Guerin 2021
# run as root / admin

# Get build essentials, including: 
# - GNU debugger
# - g++/GNU compiler collection
# - tools and libraries that are required to compile a program (G++, dpkg-dev, GCC and make, etc.).
sudo apt install build-essential

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
# snap refresh code

# 3: Install Visual Studio Code extensions for C++:
# Clang, Syntax highlighting, CMake, etc.
code --install-extension ms-vscode.cpptools # C++
code --install-extension ms-vscode.cpptools-extension-pack # C++ popular extensions
code --install-extension ms-vscode.cpptools-themes # Colorization
code --install-extension jeff-hykin.better-cpp-syntax # Syntax highlighting
code --install-extension ms-vscode.cmake-tools # CMake
code --install-extension notskm.clang-tidy # Clang
code --install-extension alesiong.clang-tidy-linter # Clang linting
