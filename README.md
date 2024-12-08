# bash-install-vscode 🚀
Bash scripts to install Visual Studio Code with GitHub Copilot on Ubuntu/Debian-based distributions

## Quick Install ⚡
One-line installation command:
```bash
wget -qO- https://raw.githubusercontent.com/yourusername/bash-install-vscode/main/install_vscode.sh | sudo bash
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
git clone https://github.com/yourusername/bash-install-vscode.git
cd bash-install-vscode
chmod +x install_vscode.sh
./install_vscode.sh
```

## Update VS Code 🔄
To update VS Code and extensions:
```bash
sudo snap refresh code
code --install-extension @outdated --force
```

## Installed Components 📦
- Build essentials (gcc, g++, make)
- Visual Studio Code (latest stable)
- C++ extensions and tools
- Clang tools and linting
- Syntax highlighting

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

## Version History 📅
- 2024.2 (Dec 8): 🔄 Enhanced distribution support
  - Added comprehensive Xubuntu support
  - Improved distribution detection
  - Added support for older Ubuntu versions
  - Enhanced error handling
- 2024.1 (Dec 8): 🎯 Removed CMake integration
  - Removed cmake-project and related files
  - Updated extensions to focus on GitHub Copilot
  - Added emojis for better readability
  - Removed unnecessary image files
- 2023.2: Added support for all Debian-based distributions
- 2023.1: Added Xubuntu support
- 2021.1: Initial release

## License ⚖️
GNU General Public License v3.0
