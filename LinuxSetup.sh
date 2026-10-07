#!/bin/sh
# ─────────────────────────────────────────
# Arch Bootstrap Script
# ─────────────────────────────────────────

systemctl enable NetworkManager
systemctl start NetworkManager

sudo pacman -Syu --noconfirm git base-devel

# ── Install yay ───────────

git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay && makepkg -si --noconfirm

# ── Installing apps ──────────────────

yay -S --noconfirm okular brave-bin vlc fastfetch htop git wget curl kitty swaybg swaync hyprland rofi gcc libreoffice-fresh strawberry waybar-git kdeconnect hyprshot ttf-font-awesome nerd-fonts ttf-nerd-fonts-symbols sddm-kcm plymouth cmake cmake-format zram-generator zsh-syntax-highlighting zsh-autosuggestions zsh nautilus helium-browser-bin hyprcap kaze-icon-theme-git darkly-bin dolphin kate konsole pavucontrol obsidian ark qtcreator waybar-module-music-git
## --- removed packages ---
# plasma-x11-session
# arandr
# clang
# replaced elisa with strawberry (music player)

# ── Kitty.conf, background opacity ──────────────────

mkdir -p ~/.config/kitty
cat > ~/.config/kitty/kitty.conf << 'EOF'
font_family CaskaydiaMono Nerd Font
background_opacity 0.8
cursor_trail 3
cursor_trail_decay 0.1 0.4
cursor_trail_start_threshold 2
EOF

# ── configuring arch linux dot files ──────────────────

mkdir -p ~/Documents/temporary  # first documents lo 'temporary' ane folder ni create chestadi
cd ~/Documents/temporary    # ippudu temporary folder loki velthunnam which we have created in documents
bsdtar -xf /run/media/$USER/Ventoy/archlinux/Hyprland.zip     # since manam ~/Documents/temporary lo unnam kabatti ventoy lo unna hyprland.zip ni extract cheste, occhi temporary lo padthai
cp -r hypr ~/.config    # ivi copy chestai .config loki
cp -r rofi ~/.config
cp -r waybar ~/.config
rm -R ~/Documents/temporary     # temporary ni delete chestam since we dont need it anymore


## login screen 1080p resolution kosam ##
#sudo rm /usr/share/sddm/scripts/Xsetup
#sudo cp /run/media/$USER/Ventoy/archlinux/Xsetup /usr/share/sddm/scripts
#sudo chmod +x /usr/share/sddm/scripts/Xsetup

## templates lo files (nautilus kosam) ##
cd ~/Templates
touch 'Empty md File.md'
touch 'Empty Text File.txt'
touch 'Empty File'

chmod +x ~/.config/waybar/scripts/archmenu.sh
chmod +x ~/.config/rofi/launchers/type-7/launcher.sh
chmod +x ~/.config/rofi/launchers/type-6/launcher.sh
chmod +x ~/.config/rofi/launchers/type-6/menulauncher.sh

cp /run/media/charanteja/Ventoy/archlinux/DiskCleanup.sh ~/Documents
chmod +x ~/Documents/DiskCleanup.sh

cp '/run/media/charanteja/Ventoy/archlinux/Notification Deamon Problem (swaync).txt' ~/Desktop
cp '/run/media/charanteja/Ventoy/archlinux/Post Installation.txt' ~/Desktop
cp /run/media/charanteja/Ventoy/archlinux/Wayland1080pfix.txt ~/Desktop


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cat /run/media/$USER/Ventoy/archlinux/zshrc >> ~/.zshrc

systemctl reboot
