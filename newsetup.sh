#!/bin/bash

# Exit on first error
set -e

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update system
sudo pacman -Syu --noconfirm

# Bluetooth section (corrected)
sudo pacman -S --noconfirm bluez bluez-utils pulseaudio blueman pulseaudio-bluetooth xdg-utils
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Packages installation
sudo pacman -S --noconfirm \
    pacman-contrib ttf-meslo-nerd fastfetch zsh git ripgrep \
    wl-clipboard neovim eza thunar wofi \
    waybar hyprland hyprpaper unzip zip p7zip yazi \
    man npm nodejs glfw swappy grim slurp wf-recorder \
    htop luarocks

# Recommendation to change shell manually
echo "To change your shell to ZSH, run: chsh -s $(which zsh)"
echo "You will need to enter your password when prompted."

# Clean up existing configurations
rm -rf ~/.config/nvim
rm -rf ~/.config/kitty
rm -rf ~/.config/hypr
rm -rf ~/.config/waybar
rm -rf ~/.config/wofi
rm -rf ~/.config/mpv
rm -rf ~/.config/xfce4
rm -rf ~/.config/Thunar
rm -rf ~/.config/fastfetch
rm -rf ~/.config/yazi

# Create necessary directories
mkdir -p ~/.config

# Copy configuration files
cp -r ./nvim/ ~/.config/
cp -r ./kitty/ ~/.config/
cp -r ./hypr/ ~/.config/
cp -r ./waybar/ ~/.config/
cp -r ./wofi/ ~/.config/
cp -r ./mpv/ ~/.config/
cp -r ./xfce4/ ~/.config/
cp -r ./Thunar/ ~/.config/
cp -r ./fastfetch/ ~/.config/
cp -r ./yazi/ ~/.config/

# Set up ZSH configuration
mkdir -p ~/.config/zsh
cd ~/.config/zsh

# Remove existing directories if they exist
rm -rf powerlevel10k
rm -rf zsh-syntax-highlighting
rm -rf zsh-autosuggestions

# Clone ZSH plugins
git clone https://github.com/romkatv/powerlevel10k.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git

# Copy configuration files from the script's directory
cp "$SCRIPT_DIR/.vimrc" ~/.vimrc
cp "$SCRIPT_DIR/.zshrc" ~/.zshrc

# Configure Fastfetch (non-interactive)
mkdir -p ~/.config/fastfetch
fastfetch --gen-config-file ~/.config/fastfetch/config.jsonc

# Open Neovim for final configuration
nvim ~/.p10k.zsh

echo "Setup complete. Remember to change your shell to ZSH manually."
