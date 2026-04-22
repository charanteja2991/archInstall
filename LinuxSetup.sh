#!/bin/bash
# ─────────────────────────────────────────
#  My Arch/Manjaro Bootstrap Script
# ─────────────────────────────────────────

set -e  # Stop if any command fails
echo "Connect to faster Internet 🚀 Starting setup... "

# ── 2. Install yay (AUR helper) ───────────

  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm

# ── 3. Install your apps ──────────────────
yay -S --noconfirm \
  okular \
  brave-bin \
  vlc \
  fastfetch \
  htop \
  git \
  wget \
  curl \
  kitty \
  plasma-x11-session \
  arandr \
  swaybg \
  swaync \
  hyprland \
  rofi \
  gcc \
  clang \
  jre8-openjdk \
  libreoffice-fresh \
  elisa \
  waybar \
  kdeconnect \
  hyprshot \
  ttf-font-awesome \
  nerd-fonts \
  ttf-nerd-fonts-symbols \
  sddm-kcm \
  plymouth \
  cmake \
  cmake-format \
  zram-generator \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  zsh \

# ── 6. Kitty.conf, background opacity ──────────────────

mkdir -p ~/.config/kitty
cat > ~/.config/kitty/kitty.conf << 'EOF'
font_family MesloLGS NF
background_opacity 0.8
EOF

# ── 7. theme for rofi ──────────────────

cd ~
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
chmod +x setup.sh
./setup.sh

# ── 8. configuring arch linux files ──────────────────

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd ~/temp
cat zshrc >> ~/.zshrc
cat xprofile >> ~/.xprofile

bsdtar -xf Hyprland.zip
cd Hyprland
cp -r hypr ~/.config
cp -r rofi ~/.config
cp -r waybar ~/.config


# ── 9. Post installation ──────────────────

echo "Update grub"
echo "Change the wifi code (some gibberish) in ~/.config/waybar/waybar.conf by command: ip -c a "
echo "Download minecraft bedrock launcher from the store if needed"
echo "Change date format to d MMM yyyy, ddd"
echo "Change kde plasma logo to arch from ~/.config/hypr/"
echo "Change Background to .png in ~/.config/hypr/"
echo "
taskbar {
    left:widgets{
        CPU-o-meter
        CPU core graphs
        Mem-o-meter
    }
    center:apps&launchers{
        arch linux apps launcher
        file manager
        konsole
        web browser
        system settings
        kate
        Minecraft Bedrock Launcher
    }
    right:widgets{
        system tray
        time & date
        virtual desktops (pagers)
    }
}"
echo "Increase all the font by 1 (Settings -> Text & Fonts)"
echo "Settings -> Colors and themes -> Window Decorations -> Oxygen"
echo "Settings -> Colors and themes -> Cursors -> Breeze Light"
echo "Settings -> Colors and themes -> Login Screen -> Breeze"
echo "Settings -> Colors and themes -> Application Style -> Oxygen"
echo "Settings -> Colors and themes -> Colors -> Breeze Dark"
echo ""
echo "Settings -> Window Management -> Window Behaviour -> Focus follows mouse && ms = 0"
echo "Settings -> Window Management -> Virtual Desktops -> {row1 - 1,2 ; row2 - 3,4}"
echo ""
echo "Settings -> Screen Locking -> {Lock after waking up:0 | Delay before password required: never required}"
echo ""
echo "Settings -> Power Management -> {When inactive: Do nothing}"
echo ""
echo "Settings -> Session -> {On login, launch apps that were open: start with empty}"



echo "✅ All done! Reboot recommended."
