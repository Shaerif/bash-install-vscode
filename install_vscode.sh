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
# snap refresh code

# 3: Install Visual Studio Code extensions for C++:
# Clang, Syntax highlighting, CMake, etc.
code --install-extension --force ms-vscode.cpptools # C++
code --install-extension --force ms-vscode.cpptools-extension-pack # C++ popular extensions
code --install-extension --force ms-vscode.cpptools-themes # Colorization
code --install-extension --force jeff-hykin.better-cpp-syntax # Syntax highlighting
code --install-extension --force ms-vscode.cmake-tools # CMake
code --install-extension --force twxs.cmake # CMake
code --install-extension --force notskm.clang-tidy # Clang
code --install-extension --force alesiong.clang-tidy-linter # Clang linting