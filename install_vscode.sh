#!/bin/sh
# Claire Guerin 2021-2024
# run as root / admin

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect distro
detect_distro() {
    if command_exists lsb_release; then
        DISTRO=$(lsb_release -is)
        VERSION=$(lsb_release -rs)
    elif [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        VERSION=$VERSION_ID
    else
        echo "Cannot detect distribution. Assuming Debian-based system."
        DISTRO="Unknown"
        VERSION="0"
    fi
}

# Detect distribution
detect_distro

# Install prerequisites
echo "🔍 Detecting system: $DISTRO $VERSION"
sudo apt update
sudo apt install -y build-essential curl wget

# Install snapd if not present
if ! command_exists snap; then
    echo "📦 Installing snapd..."
    sudo apt update
    sudo apt install -y snapd
    sudo systemctl enable snapd
    sudo systemctl start snapd
fi

# Special handling for different distributions
case "$DISTRO" in
    "Xubuntu"|"xubuntu")
        echo "🎯 Detected Xubuntu - ensuring snapd compatibility..."
        sudo apt install -y snapd
        ;;
    "Ubuntu"|"ubuntu")
        echo "🎯 Detected Ubuntu - checking version compatibility..."
        ;;
    *)
        echo "🎯 Detected Debian-based system - installing required components..."
        sudo apt install -y apt-transport-https
        ;;
esac

# Install VS Code
echo "📥 Installing Visual Studio Code..."
sudo snap install --classic code

# Install GitHub Copilot extensions
echo "🤖 Installing GitHub Copilot extensions..."
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat

echo "✅ Installation complete!"