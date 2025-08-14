# Hyprland Installer (Custom Configs)

## 📄 Description

This is a simple script to install **Hyprland** with my personal **configuration files**.  
I made it for myself to easily set up a desktop environment on any machine.

## ✨ Features

- Installs all required packages
- Applies my custom dotfiles and keybindings
- Sets up a complete environment (Waybar, Wofi, etc.)
- Optional cleanup after install

## 🔧 Requirements

- Linux (Arch-based system)
- Internet connection
- `git`, `bash`, `sudo`, `poetry`

## 🛠️ Installation

### 1. Clone the repo (if not cloned yet)

``` bash 
mkdir -p ~/.config/.dotfiles/
cd ~/.config/.dotfiles/
git clone https://github.com/Mikola-Afanasiev/dotfiles_hyprland
```

### 2. Install poetry (if not installed yet)
``` bash
sudo pacman -S poetry --noconfirm
```

### 3. Run the installer script
⚠️ Warning: This script will overwrite some of your configs (like ~/.config/hypr/), so make backups if needed.
``` bash
cd ~/.config/.dotfiles/system/system_installer/script/
poetry run python3 setup.py
```
