#!/bin/bash
#
# Typical Ubuntu 18.04 LTS initial server setup
# Adds repositories and changes to ET timezone
#
# Created 11/12/2018 by LTewksbury
#

# Change timezone to Eastern time
sudo timedatectl set-timezone America/New_York

# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Add multiverse repositories to Ubuntu Server 18.04
sudo add-apt-repository universe
sudo add-apt-repository multiverse

# Find and install updates
sudo apt-get update && sudo apt-get upgrade -y

# Set the server up for automatic updates
# Additional info is at https://help.ubuntu.com/lts/serverguide/automatic-updates.html
# sudo tee /etc/apt/apt.conf.d/20auto-upgrades <<< 'APT::Periodic::Update-Package-Lists "1";'
# sudo tee -a /etc/apt/apt.conf.d/20auto-upgrades <<< 'APT::Periodic::Download-Upgradeable-Packages "1";'
# sudo tee -a /etc/apt/apt.conf.d/20auto-upgrades <<< 'APT::Periodic::AutocleanInterval "7";'
# sudo tee -a /etc/apt/apt.conf.d/20auto-upgrades <<< 'APT::Periodic::Unattended-Upgrade "1";'
echo 'APT::Periodic::Update-Package-Lists "1";' > /etc/apt/apt.conf.d/20auto-upgrades
echo 'APT::Periodic::Download-Upgradeable-Packages "1";' >> /etc/apt/apt.conf.d/20auto-upgrades
echo 'APT::Periodic::AutocleanInterval "7";' >> /etc/apt/apt.conf.d/20auto-upgrades
echo 'APT::Periodic::Unattended-Upgrade "1";' >> /etc/apt/apt.conf.d/20auto-upgrades
# sed uses RegEx to replace words and doesn't always recognize the '\t' for Tab
sudo sed -i -e 's+//\t"${distro_id}:${distro_codename}-+\t"${distro_id}:${distro_codename}-+g' /etc/apt/apt.conf.d/50unattended-upgrades

# Install PowerShell
sudo apt-get install PowerShell
