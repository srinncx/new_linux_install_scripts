#!/bin/bash

# -------------------------------
# 🌟 Script: install_all_software.sh
# 📌 Description: Installs APT and Flatpak packages with logging, emojis, and clear formatting.
# -------------------------------

# Log file
LOGFILE="/var/log/install_all_software.log"

# Redirect all stdout and stderr to log file AND terminal
exec > >(tee -a "$LOGFILE") 2>&1

# Colors
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
BLUE="\033[1;34m"
NC="\033[0m" # No Color

# Check for root privileges
if [[ "$EUID" -ne 0 ]]; then
    echo -e "\n${RED}❌ Please run this script as root (e.g., sudo ./install_all_software.sh)${NC}\n"
    exit 1
fi

echo -e "\n${BLUE}🔧 Starting full system setup... $(date)${NC}"
echo -e "📁 Log file: ${YELLOW}$LOGFILE${NC}"
echo -e "---------------------------------------------\n"

# -------------------------------------------------
# 📦 APT INSTALLATION FUNCTIONS
# -------------------------------------------------

check_apt_package_installed() {
    dpkg -s "$1" &> /dev/null
}

update_package_list() {
    echo -e "\n${BLUE}🔄 Updating APT package list...${NC}\n"
    apt update -y
}

install_apt_packages() {
    echo -e "\n${BLUE}📦 Installing APT packages...${NC}\n"

    local packages=(
        "timeshift" "gufw" "eza" "dysk" "nala" "starship"
        "git" "preload" "bat" "vim" "micro" "ncdu" "curl"
        "build-essential" "python3" "python3-pip" "openssh-server"
        "openssh-client" "ttf-mscorefonts-installer"
        "fonts-jetbrains-mono" "ubuntu-restricted-extras"
    )

    for package in "${packages[@]}"; do
        if check_apt_package_installed "$package"; then
            echo -e "${YELLOW}  ⚠️  $package is already installed. Skipping.${NC}"
        else
            echo -e "  📥 Installing ${package}..."
            apt install -y "$package"
            echo -e "${GREEN}  ✅ $package installed successfully.${NC}"
        fi
        echo    # blank line
    done

    echo -e "${GREEN}✅ All APT packages processed.${NC}\n"
}

# -------------------------------------------------
# 📦 FLATPAK INSTALLATION FUNCTIONS
# -------------------------------------------------

check_flatpak() {
    if ! command -v flatpak &> /dev/null; then
        echo -e "${YELLOW}⚠️  Flatpak not found. Installing...${NC}\n"
        apt install -y flatpak
    else
        echo -e "${GREEN}✅ Flatpak is already installed.${NC}\n"
    fi
}

add_flathub_repo() {
    echo -e "${BLUE}🌐 Ensuring Flathub repository is added...${NC}\n"
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    echo -e "${GREEN}✅ Flathub is ready.${NC}\n"
}

install_flatpak_apps() {
    echo -e "\n${BLUE}📦 Installing Flatpak applications...${NC}\n"

    local apps=(
        "org.mozilla.firefox" "com.brave.Browser" "org.libreoffice.LibreOffice"
        "io.github.peazip.PeaZip" "org.bleachbit.BleachBit" "com.usebottles.bottles"
        "com.github.tchx84.Flatseal" "io.github.flattool.Warehouse"
        "com.valvesoftware.Steam" "com.heroicgameslauncher.hgl"
        "net.lutris.Lutris" "net.davidotek.pupgui2" "com.vysp3r.ProtonPlus"
        "org.keepassxc.KeePassXC" "com.bitwarden.desktop" "md.obsidian.Obsidian"
        "org.videolan.VLC" "org.qbittorrent.qBittorrent" "com.vscodium.codium"
        "com.obsproject.Studio"
    )

    for app in "${apps[@]}"; do
        echo -e "  📥 Installing ${app}..."
        flatpak install -y flathub "$app"
        echo -e "${GREEN}  ✅ $app installed.${NC}\n"
    done

    echo -e "${GREEN}✅ All Flatpak apps processed.${NC}\n"
}

# -------------------------------------------------
# 🚀 MAIN FUNCTION
# -------------------------------------------------

main() {
    update_package_list
    install_apt_packages

    check_flatpak
    add_flathub_repo
    install_flatpak_apps

    echo -e "${GREEN}🎉 All installations completed successfully!${NC}"
    echo -e "📅 Finished at: $(date)\n"
}

main
