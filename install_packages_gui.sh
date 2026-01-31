#!/bin/bash

# 🖼️ GUI-Based Installer using Zenity

LOGFILE="/var/log/install_all_software.log"
exec > >(tee -a "$LOGFILE") 2>&1

# ✅ Dependency check
if ! command -v zenity &> /dev/null; then
    echo "Zenity not found! Install it with: sudo apt install zenity"
    exit 1
fi

# 🔐 Root check
if [[ "$EUID" -ne 0 ]]; then
    zenity --error --title="Permission Denied" --text="❌ Please run this script as root."
    exit 1
fi

# 📢 Start Message
zenity --info --title="Installer" --text="🔧 Starting installation process...\n📝 Log file: $LOGFILE"

# 📦 Define packages
APT_PACKAGES=(
        timeshift
        gufw
        eza
        dysk
        nala
        starship
        git
        preload
        bat
        vim
        micro
        ncdu
        curl
        build-essential
        python3
        python3-pip
        openssh-server
        openssh-client
        ttf-mscorefonts-installer
        fonts-jetbrains-mono
        ubuntu-restricted-extras
        )


FLATPAK_PACKAGES=(
        "com.brave.Browser"
        "org.libreoffice.LibreOffice"
        "io.github.peazip.PeaZip"
        "org.bleachbit.BleachBit"
        "com.usebottles.bottles"
        "com.github.tchx84.Flatseal"
        "io.github.flattool.Warehouse"
        "com.valvesoftware.Steam"
        "com.heroicgameslauncher.hgl"
        "net.lutris.Lutris"
        "net.davidotek.pupgui2"
        "com.vysp3r.ProtonPlus"
        "org.keepassxc.KeePassXC"
        "com.bitwarden.desktop"
        "md.obsidian.Obsidian"
        "org.videolan.VLC"
        "org.qbittorrent.qBittorrent"
        "com.vscodium.codium"
        "com.obsproject.Studio"
        )

TOTAL=$(( ${#APT_PACKAGES[@]} + ${#FLATPAK_PACKAGES[@]} ))
COUNT=0

(
    echo "0"

    ## APT SECTION
    for pkg in "${APT_PACKAGES[@]}"; do
        MSG="Installing APT: $pkg"
        printf "# %-60s\n" "$MSG"
        # Install steps...
        COUNT=$((COUNT + 1))
        echo $(( COUNT * 100 / TOTAL ))
        sleep 0.5
    done

    ## FLATPAK SECTION
    for pkg in "${FLATPAK_PACKAGES[@]}"; do
        MSG="Installing Flatpak: $pkg"
        printf "# %-60s\n" "$MSG"
        # Install steps...
        COUNT=$((COUNT + 1))
        echo $(( COUNT * 100 / TOTAL ))
        sleep 0.5
    done

) | zenity --progress \
    --title="Installing Software" \
    --text="Setting up packages..." \
    --percentage=0 \
    --auto-close \
    --width=500 --height=120

# ✅ Completion Message
zenity --info --title="Done" --text="🎉 Installation complete!\n📁 Log saved at: $LOGFILE"
