#!/bin/bash


# Function to check if a package is installed


check_package_installed() {
    dpkg -s "$1" &> /dev/null
}


# Function to update the apt package list


update_package_list() {
    echo "Updating package list..."
    apt update
}


# Function to install all packages
# List of packages to install from apt repositories



install_software() {
    packages=(
    	"flatpak"
    	"gnome-software"
    	"gnome-software-plugin-flatpak"
    	"gnome-tweaks"
        "timeshift"
        "gufw"
        "eza"
        "dysk"
        "nala"
        "starship"
        "git"
        "preload"
        "bat"
        "vim"
        "micro"
        "ncdu"
        "curl"
        "build-essential"
        "python3"
        "python3-pip"
        "openssh-server"
        "openssh-client"
        "ttf-mscorefonts-installer"
        "fonts-jetbrains-mono"
        "ubuntu-restricted-extras"
    )

# Add extra packages if you want to extra packages
# Install the packages from the list
# Check if the package is already installed
# Install the package with `apt` if it isn't already installed


    for package in "${packages[@]}"; do
        if check_package_installed "$package"; then
            echo "$package is already installed. Skipping."
        else
            echo "Installing $package..."
            apt install -y "$package"
        fi
    done

    echo "All requested packages are installed or up-to-date."
}


# Main function to execute the process
# Update package list first to ensure we're getting the latest version
# Install the packages (including fonts, Java, codecs, etc.)


main() {
    update_package_list
    install_software
}


# Run the main function to start the process


main

# Make the script executable
#chmod +x install_apt_packages.sh

