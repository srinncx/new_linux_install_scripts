---
# 🐧 New Linux Install Scripts

A collection of **Bash scripts** designed to automate post-installation setup on a fresh Linux system.

This repository focuses on quickly installing essential software using:

* **APT packages**
* **Flatpak packages**
* Custom install scripts
* A **work-in-progress GUI installer**

> ⚠️ **USE WITH CAUTION** — These scripts make system-level changes and install packages automatically. ([GitHub][1])

---

## 📦 Repository Contents

### 🔧 Installation Scripts

* `install_apt_packages.sh`
  Installs software using the APT package manager.

* `install_flatpaks.sh`
  Installs applications via Flatpak.

* `install_packages.sh`
  Combined installer script for multiple package sources.

* `install_packages_gui.sh`
  Work-in-progress GUI installer for package selection and installation.

### ⚙️ Config Files

* `.bash_aliases`
  Custom shell aliases for productivity and workflow improvements.

---

## 🧩 Features

* One-shot post-install setup
* Automated package installation
* Supports both APT & Flatpak ecosystems
* Beginner-friendly automation
* Expandable modular scripts
* Experimental GUI installer

---

## 🖥️ Target Use Case

Ideal for:

* Fresh Linux installations
* Distro hopping setups
* Developer workstation provisioning
* Lab / college system setup
* VM quick provisioning

---

## ⚠️ Disclaimer

* Scripts may install large numbers of packages.
* Some packages may conflict with existing setups.
* GUI installer is **still under development**.
* Review scripts before running on production systems.

---

## 🛠 Requirements

* Debian/Ubuntu-based Linux distro (APT support)
* Flatpak installed (or install via script)
* Sudo privileges
* Internet connection

---





[1]: https://github.com/srinncx/new_linux_install_scripts "GitHub - srinncx/new_linux_install_scripts: This repo is a collection of bash scripts for new linux using for apt and flatpak packages. It also have the bash script for work in progress gui installer. \"USE WITH CAUTION\""
