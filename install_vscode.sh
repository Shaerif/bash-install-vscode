#!/bin/sh
# Claire Guerin 2021-2024
# run as root / admin

# Default values
INSTALL_PATH=""
NON_INTERACTIVE=false
CUSTOM_EXTENSIONS=""
SKIP_SNAP=false
SKIP_BUILD=false
MINIMAL_INSTALL=false

# Parse command line arguments
while [ $# -gt 0 ]; do
    case "$1" in
        --install-path)
            INSTALL_PATH="$2"
            shift 2
            ;;
        --yes)
            NON_INTERACTIVE=true
            shift
            ;;
        --extensions)
            CUSTOM_EXTENSIONS="$2"
            shift 2
            ;;
        --no-snap)
            SKIP_SNAP=true
            shift
            ;;
        --no-build)
            SKIP_BUILD=true
            shift
            ;;
        --minimal)
            MINIMAL_INSTALL=true
            SKIP_BUILD=true
            shift
            ;;
        *)
            echo "❌ Unknown option: $1"
            exit 1
            ;;
    esac
done

# Enable debug mode if needed
if [ "$DEBUG" = "true" ]; then
    set -x
fi

# Error handling
set -e
trap 'echo "❌ Error occurred at line $LINENO. Exiting..."; exit 1' ERR

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
        echo "⚠️ Cannot detect distribution. Assuming Debian-based system."
        DISTRO="Unknown"
        VERSION="0"
    fi
}

# Function to check internet connectivity
check_internet() {
    if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        echo "❌ No internet connection. Please check your network."
        exit 1
    fi
}

# Check if running as root
if [ "$(id -u)" != "0" ]; then
    echo "❌ This script must be run as root or with sudo"
    exit 1
fi

# Check internet connectivity
check_internet

# Detect distribution
detect_distro

# Install prerequisites
echo "🔍 Detecting system: $DISTRO $VERSION"
sudo apt update || { echo "❌ apt update failed"; exit 1; }
if [ "$SKIP_BUILD" = "false" ]; then
    sudo apt install -y build-essential curl wget || { echo "❌ Failed to install prerequisites"; exit 1; }
else
    sudo apt install -y curl wget || { echo "❌ Failed to install prerequisites"; exit 1; }
fi

# Install snapd if needed
if [ "$SKIP_SNAP" = "false" ]; then
    if ! command_exists snap; then
        echo "📦 Installing snapd..."
        sudo apt install -y snapd || { echo "❌ Failed to install snapd"; exit 1; }
        sudo systemctl enable snapd || true
        sudo systemctl start snapd || true
        sleep 2
    fi
fi

# Special handling for different distributions
case "$DISTRO" in
    "Xubuntu"|"xubuntu")
        echo "🎯 Detected Xubuntu - ensuring snapd compatibility..."
        sudo apt install -y snapd xfce4-terminal || true
        ;;
    "Ubuntu"|"ubuntu")
        echo "🎯 Detected Ubuntu - checking version compatibility..."
        if [ "${VERSION%.*}" -lt "16" ]; then
            echo "⚠️ Ubuntu version < 16.04. Some features might not work."
        fi
        ;;
    *)
        echo "🎯 Detected Debian-based system - installing required components..."
        sudo apt install -y apt-transport-https
        ;;
esac

# Function to use .deb package for VS Code installation
use_deb_package() {
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y code
    rm packages.microsoft.gpg
}

# Install VS Code
echo "📥 Installing Visual Studio Code..."
if [ "$SKIP_SNAP" = "false" ]; then
    sudo snap install --classic code || use_deb_package
else
    use_deb_package
fi

# Verify VS Code installation
if ! command_exists code; then
    echo "❌ VS Code installation failed"
    exit 1
fi

# Install extensions
if [ -n "$CUSTOM_EXTENSIONS" ]; then
    echo "🔧 Installing custom extensions..."
    for ext in $CUSTOM_EXTENSIONS; do
        code --install-extension "$ext" || echo "⚠️ Failed to install extension: $ext"
    done
else
    echo "🤖 Installing GitHub Copilot extensions..."
    code --install-extension GitHub.copilot || echo "⚠️ Failed to install GitHub Copilot extension"
    code --install-extension GitHub.copilot-chat || echo "⚠️ Failed to install GitHub Copilot Chat extension"
fi

# Add custom installation path handling if specified
if [ -n "$INSTALL_PATH" ]; then
    echo "📁 Setting custom installation path: $INSTALL_PATH"
    mkdir -p "$INSTALL_PATH"
    if [ -d "/usr/share/code" ]; then
        cp -r /usr/share/code/* "$INSTALL_PATH/"
    fi
fi

echo "✅ Installation complete! Please log out and log back in for all changes to take effect."