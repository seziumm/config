# FOR MINECRAFT 1.8.9 you need 
# java-8-openjdk
# makes Minecraft 1.8.9 work for me.

#/!/bin/bash

# BROTHERS PRINTER SETUP
# sudo pacman -S cups
# sudo systemctl enable cups
# sudo systemctl start cups
# yay -S brother-hl1210w
# git clone https://aur.archlinux.org/brother-hl1210w.git


# Fonts: Swappy relies on Font Awesome 5 being present to properly render the icons. 
# On Arch you can simply install those with: sudo pacman -S otf-font-awesome

# cd brother-hl1210w/
#
# makepkg -si
#
# cd src/opt/brother/Printers/HL1210W/cupswrapper/
#
# sudo cp brother_lpdwrapper_HL1210W /usr/lib/cups/filter/
# sudo pacman -S system-config-printer
#
# Set the printer
#
# Install system-config-printer sudo pacman -S system-config-printer
#
#
# Open system-confing-printer
# WIN + D per il menu' e cercare printer. entra
#
#
# ACCENDI LA STAMPANTE.
# CERCA: SERVER -> FIND NETWORK PRINTER -> FORWARD (DENTRO HOST NON METTERE NIENTE) E TE LA TROVA.
# Add printer
#
# Select device Brother HL-1210...
#
# Provide PPD file: select in the repo src/opt/brother/Printers/HL1210W/cupswrapper/brother-HL1210W-cups-en.ppd
#
# Next and done


# sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils
# sudo pacman -S nvidia-settings
#
#
# edit 
#
# sudo grub-mkconfig -o /boot/grub/grub.cfg
#
# sudo nvim /etc/default/grub
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia-drm.modeset=1"
#
# sudo nvim /etc/mkinitcpio.conf
# MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
# HOOKS=()
# sudo mkinitcpio -P

# Adding the Pacman Hook:
# Get the nvidia.hook -file from this repository
#
#     cd ~
#     wget https://raw.githubusercontent.com/korvahannu/arch-nvidia-drivers-installation-guide/main/nvidia.hook
#
# Open the file with your preferred editor.
#
#     nano nvidia.hook
#
# Find the line that says Target=nvidia.
# Replace the word nvidia with the base driver you installed, e.g., nvidia-470xx-dkms
#
#     The edited line should look something like this: Target=nvidia-470xx-dkms
#
# Save the file with CTRL+S and close nano with CTRL+X
# Move the file to /etc/pacman.d/hooks/ with: sudo mkdir -p /etc/pacman.d/hooks/ && sudo mv ./nvidia.hook /etc/pacman.d/hooks







# seeeeeeeeee this 
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
# sudo pacman -S wev to find key codes etc
#



timedatectl set-local-rtc 1 --adjust-system-clock
# --------------------- ly --------------------- #
sudo pacman -S --noconfirm ly

sudo systemctl enable ly.service
# sudo systemctl start ly.service



# --------------------- PACKAGES --------------------- #

sudo pacman -Syu
sudo pacman -S --noconfirm pacman-contrib ttf-meslo-nerd fastfetch zsh git ripgrep wl-clipboard neovim eza alacritty firefox thunar wofi waybar hyprland hyprpaper unzip zip p7zip yazi man npm nodejs glfw swappy grim slurp wf-recorder htop luarocks
#
# per fare vidoe, wf-recorder (lo avvii da terminale e con control-c finisci di registrare.) 
# swappy per editare le immagini
# mpv per vedere i video


sudo pacman -S --noconfirm base-devel fftw alsa-lib iniparser pulseaudio autoconf-archive pkgconf

# --------------------- ZSH SHELL --------------------- #
chsh -s $(which zsh)


# xdg-mime default thunar.desktop inode/directory
# set defualt file manager for firefox

# --------------------- BLUETOOTH --------------------- #

sudo pacman -S --noconfirm bluez bluez-utils pulseaudio blueman pulseaudio-bluetooth xdg-open
sudo systemctl start bluetooth
sudo systemctl enable bluetooth


# ---------------------     YAY      --------------------- #


cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~

yay -S brave-bin
yay -S donut.c

# ------------------------- NVIM ------------------------- #

# Clone Packer.nvim

# Elimina le vecchie configurazioni di nvim
echo "Deleting older nvim config..." 

rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim


echo "Installing nvim packer..." 

mkdir -p ~/.config/

cp -r ./nvim/ ~/.config/


echo "Use g + ? to see nvim-tree commands\n\n"
echo "Nvim is done"


# --------------------- ALACRITTY --------------------- #

# sudo pacman -Syu ttf-meslo
rm -rf ~/.config/kitty/

mkdir -p ~/.config/kitty


if [ $? -ne 0 ]; then
  echo "Failed to remove old kitty config."
  exit 1
fi

cp -r ./kitty/ ~/.config/

echo "Alacritty is done"


# ---------------------   CURSOR     --------------------- #

echo "Installing cursor theme..."

sudo pacman -Syu
sudo pacman -S nwg-look
yay -S rose-pine-hyprcursor
yay -S rose-pine-cursor

unzip RosePine-Dark-B-MB.zip
sudo cp -r Rosepine-Dark/ /usr/share/themes


nwg-look

echo "Cursor is done"


# ---------------------   HYPRLAND --------------------- #

echo "Installing hyprland..."
rm -rf ~/.config/hypr/

mkdir -p ~/.config/hypr

if [ $? -ne 0 ]; then
  echo "Failed to remove old hypr config."
  exit 1
fi

cp -r ./hypr/ ~/.config/

echo "Hyprland is done"

# ---------------------   WAYBAR --------------------- #

echo "Installing Waybar..."
rm -rf ~/.config/waybar/

mkdir -p ~/.config/waybar

cp -r ./waybar/ ~/.config/

echo "Waybar is done"

# ---------------------  MPV ---------------------- #
cp -r ./mpv/ ~/.config/

# --------------------- THUNAR -------------------- #

cp -r ./xfce4/ ~/.config/
cp -r ./Thunar/ ~/.config/

# ------------------- FASTFETCH ------------------- #

cp -r ./fastfetch/ ~/.config/


# --------------------- YAZI ---------------------- #
cp -r ./yazi/ ~/.config/

# ---------------------  WOFI --------------------- #

echo "Installing Wofi..."
rm -rf ~/.config/waybar/

mkdir -p ~/.config/wofi

cp -r ./wofi/ ~/.config/

echo "Wofi is done"

echo "ALL DONE!"

fastfetch --gen-config
 
mkdir ~/.config/zsh
cd ~/.config/zsh

git clone https://github.com/romkatv/powerlevel10k.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git

cp -r ./.vimrc ~/.vimrc
cp -r ./.zshrc ~/.zshrc

nvim ~/.p10k.zsh


#   search for this line and set to 0
#   typeset -g POWERLEVEL9K_DIR_BACKGROUND=0






# # --------------------- ZSH CONF ------------------- #
#
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
#
# #--------------------------------------------------#
#
# export EDITOR=nvim
# export VISUAL=nvim
# export LANG=en_US.UTF-8
# export LC_TIME=en_US.UTF-8
# #--------------------------------------------------#
#
# HISTFILE=~/.config/zsh/.zsh_history
#
# SAVEHIST=1000
# HISTSIZE=999
# setopt share_history
# setopt hist_expire_dups_first
# setopt hist_ignore_dups
# setopt hist_verify
# setopt globdots
#
# bindkey '^P' history-search-backward
# bindkey '^N' history-search-forward
# bindkey '^[I' autosuggest-accept
# #--------------------------------------------------#
#
# alias nvimconf="nvim ~/.config/nvim/"
# alias zshconf="nvim ~/.zshrc"
# alias hyprconf="nvim ~/.config/hypr/"
# alias alacrittyconf="nvim ~/.config/alacritty/alacritty.toml"
# alias waybarconf="nvim ~/.config/waybar"
# alias h="history"
# alias vi="nvim"
# alias svi="sudoedit nvim"
#
# alias ls="eza --color=always --long --icons=always --no-time --no-permissions --no-user" 
# alias tree="eza --color=always --long --icons=always --no-time --no-permissions --tree --no-user" 
# # --all per vedere i file nascosti
#
# #--------------------------------------------------#
# source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
# source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#
#
#
#
#
#
#
#
#
# Se Vuoi installare solo NvimChad nvimchad:
#
# #git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
#
# Run :MasonInstallAll command after lazy.nvim finishes downloading plugins.
# Delete the .git folder from nvim folder.
# Learn customization of ui & base46 from :h nvui.
#
#
#
#
#
#
# Linux / MacOS (unix)
# rm -rf ~/.config/nvim
# rm -rf ~/.local/state/nvim
# rm -rf ~/.local/share/nvim
