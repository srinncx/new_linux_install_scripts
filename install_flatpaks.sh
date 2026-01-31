#!/bin/bash


# Function to check if Flatpak is installed
# Check if the `flatpak` command exists (which means Flatpak is installed)
# If Flatpak is not installed, install it using the package manager (assuming Ubuntu/Debian-based)


check_flatpak() {
    if ! command -v flatpak &> /dev/null; then
        echo "Flatpak is not installed. Installing Flatpak..."
        apt update && apt install -y flatpak
    else
        echo "Flatpak is already installed."
    fi
}


# Function to add Flathub repository (if not already added)
# Flathub is the default source for most Flatpak apps


add_flathub_repo() {
    echo "Adding Flathub repository..."
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}


# Function to install the Flatpak apps


install_apps() {
    echo "Installing applications..."


# List of Flatpak app IDs that we want to install
# These are the official app IDs used on Flathub


    apps=(
        "org.mozilla.firefox"
        "com.mattjakeman.ExtensionManager"
        "io.missioncenter.MissionCenter"
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


# Add extra app ID's if you want to extra apps
# Loop through each app in the list and install it using flatpak


    for app in "${apps[@]}"; do
        echo "Installing $app..."
        flatpak install -y flathub "$app"
    done

    echo "All applications installed!"
}


# Main function
# Check if Flatpak is installed, and install it if needed
# Add the Flathub repository (if not already added)
# Install the list of applications from Flathub

main() {
    check_flatpak
    add_flathub_repo
    install_apps
}


# Run the main function


main


# Make the script executable
# chmod +x install_flatpaks.sh
