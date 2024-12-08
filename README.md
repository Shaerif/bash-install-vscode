# bash-install-vscode 🚀

Quick and easy VS Code installation with GitHub Copilot for Ubuntu/Debian systems.

## Table of Contents 📑
- [Quick Install](#quick-install-)
- [Requirements](#requirements-)
- [System Compatibility](#system-compatibility-%EF%B8%8F)
- [Manual Installation](#manual-installation-%EF%B8%8F)
- [Update VS Code](#update-vs-code-)
- [Installed Components](#installed-components-)
- [Restricted Mode](#restricted-mode-)
- [Troubleshooting](#troubleshooting-)
- [Advanced Installation](#advanced-installation-options-%EF%B8%8F)
- [Upcoming Features](#upcoming-features-)
- [Version History](#version-history-)

## Quick Install ⚡
One-line installation command:
```bash
wget -qO- https://raw.githubusercontent.com/Shaerif/bash-install-vscode/refs/heads/main/install_vscode.sh | sudo bash
```

## Requirements 📋
- Ubuntu 16.04+ or Debian-based distribution 
- Root/sudo privileges
- Internet connection
- Minimum 1GB free disk space

## System Compatibility 🖥️
- Ubuntu (all versions)
- Xubuntu (fully supported) 
- Linux Mint
- Debian
- Pop!_OS
- Elementary OS
- Zorin OS
- Any Debian-based distribution

### Xubuntu-specific Notes 🎯
This script has been specially optimized for Xubuntu with:
- Automatic snapd configuration
- Desktop environment compatibility checks
- Xfce integration support

## Manual Installation 🛠️
1. Clone the repository:
```bash
git clone https://github.com/Shaerif/bash-install-vscode.git
cd bash-install-vscode
chmod +x install_vscode.sh
./install_vscode.sh
```

## Update VS Code 🔄

### Automatic Update (Recommended)
```bash
sudo snap refresh code
code --install-extension @outdated --force
```

### Manual Update Options
```bash
# Update specific components
sudo bash install_vscode.sh --yes --minimal    # VS Code only
sudo bash install_vscode.sh --yes --no-build   # VS Code + extensions
sudo bash install_vscode.sh --extensions "github.copilot"  # Specific extension
```

## Installed Components 📦
- Visual Studio Code (latest stable via snap)
- GitHub Copilot
- GitHub Copilot Chat
- Build essentials (gcc, g++, make)
- Git (latest stable)
- Common development tools and libraries

## Restricted Mode 🔒

It might be that upon opening Visual Studio Code, some of the installed extensions are disabled. This is because you are using VS code in **restricted mode**. 

From the Visual Studio Code documentation on Workspace Trust:

> Restricted Mode tries to prevent automatic code execution by disabling or limiting the operation of several VS Code features: tasks, debugging, workspace settings, and extensions.

To view the list of disabled extensions, go to *Extensions* on the left-hand side menu (`Ctrl+Shift+X`), the search `@workspaceUnsupported`. 

You can circumvent this problem by selecting `Trust` in the central panel:

More information:

- [VS Code's Workspace Trust](https://code.visualstudio.com/docs/editor/workspace-trust)
- [Workaround & Manage Settings](https://stackoverflow.com/a/67940194)

## Troubleshooting 🔧
If you encounter issues:
1. Verify internet connectivity
2. Check sudo privileges
3. For Snap errors:
```bash
sudo apt update
sudo apt install snapd
sudo snap install core
```
4. For extension installation failures:
```bash
code --list-extensions
code --install-extension <extension-id> --force
```

## Advanced Installation Options 🛠️

The script supports several command-line arguments for customized installation:

### Custom Installation Path
Specify a custom installation directory:
```bash
sudo bash install_vscode.sh --install-path /custom/path
```

### Non-Interactive Mode
Run the script without any prompts:
```bash
sudo bash install_vscode.sh --yes
```

### Extension Management
Install specific extensions during setup:
```bash
sudo bash install_vscode.sh --extensions "ms-python.python ms-vscode.cpptools"
```
### Component Selection
Control which components to install by combining flags:
```bash
sudo bash install_vscode.sh --no-snap --no-build --minimal
```

### Debug Mode
Run the script in debug mode:
```bash
bash -x install_vscode.sh
```

## Upcoming Features 🚀
- [ ] Offline installation support
- [ ] Extension profiles (Development, Data Science, Web)
- [ ] Auto-configuration backup/restore
- [ ] Multi-user installation support
- [ ] Custom themes and settings presets
- [ ] Docker development container support
- [ ] System health checks and optimization

## Version History 📅

- 2024.2 (Current): 🛠️ Command-line Enhancement
  - Added installation options (--install-path, --yes, etc.)
  - Component selection support
  - Custom extension installation
  - Enhanced error handling and recovery
- 2024.2: 🔄 Enhanced distribution support
  - Added comprehensive Xubuntu support
  - Improved distribution detection
  - Added support for older Ubuntu versions
  - Enhanced error handling
- 2024.1: 🤖 GitHub Copilot Focus
  - Streamlined GitHub Copilot integration
  - Removed legacy components
  - Added documentation emojis
  - Distribution detection improvements
- 2023.2: Added support for all Debian-based distributions
- 2023.1: Added Xubuntu support
- 2021.1: Initial release

## License ⚖️
GNU General Public License v3.0
