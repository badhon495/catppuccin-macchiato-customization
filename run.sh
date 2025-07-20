#!/bin/bash

# Exit on error
set -e

# Variables (update these paths if needed)
USER_NAME=$(whoami)
THEME_ARCHIVE="$HOME/Downloads/Catppuccin-Macchiato-Dark-Border-MacOS-Buttons.tar.xz"
CURSOR_ARCHIVE="$HOME/Downloads/Catppuccin-Macchiato-Dark.tar.xz"
FOLDER_ARCHIVE="$HOME/Downloads/Tela-Circle-Nord.tar.xz"
KVANTUM_ARCHIVE="$HOME/Downloads/catppuccin-macchiato-blue.zip"
WALLPAPER_URL="https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/master/purpled-night.jpg"

echo "Installing desktop theme..."
sudo tar -xf "$THEME_ARCHIVE" -C /usr/share/themes/

echo "Installing cursor theme..."
sudo tar -xf "$CURSOR_ARCHIVE" -C /usr/share/icons/

echo "Installing folder theme..."
sudo tar -xf "$FOLDER_ARCHIVE" -C /usr/share/icons/

echo "Setting up wallpaper..."
wget -O "$HOME/Pictures/catppuccin-wallpaper.jpg" "$WALLPAPER_URL"

echo "Installing Qt and Kvantum packages..."
sudo apt update
sudo apt install -y qt5ct qt6ct qt5-style-plugins qt6-style-plugins kvantum qt5-style-kvantum qt6-style-kvantum unzip

echo "Configuring Qt environment variables..."
echo -e "\nexport QT_QPA_PLATFORMTHEME=qt5ct\nexport QT_STYLE_OVERRIDE=kvantum" >> "$HOME/.profile"
source "$HOME/.profile"

echo "Installing Kvantum theme..."
mkdir -p "$HOME/.kvantum"
unzip "$KVANTUM_ARCHIVE" -d "$HOME/.kvantum/catppuccin-macchiato-blue"

echo "Installing Flatseal (for Flatpak theme management)..."
sudo apt install -y flatpak
flatpak install -y flathub com.github.tchx84.Flatseal

echo "Setting up themes for Flatpak apps..."
mkdir -p "$HOME/.themes"
cp -r /usr/share/themes/Catppuccin-Macchiato-Dark-Border-MacOS-Buttons "$HOME/.themes/"
cp -r /usr/share/icons/Tela-Circle-Nord "$HOME/.themes/"

echo "Add the following lines to Flatpak environment (manual step):"
echo "GTK_THEME=Catppuccin-Macchiato-Dark-Border-MacOS"
echo "GTK_ICON_THEME=Tela-Circle-Nord"
echo "You can set these in Flatseal > All Applications > Environment."

echo "Setup complete! Please restart your computer to apply all changes."