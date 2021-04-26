#!/bin/bash

echo "fastestmirror=true" >> /etc/dnf/dnf.conf
echo "deltarpm=true" >> /etc/dnf/dnf.conf

sudo dnf update -y
sudo dnf upgrade -y

sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf groupupdate core

sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.spotify.Client -y
flatpak install flathub com.discordapp.Discord -y

sudo dnf install steam freecad inkscape gnome-tweaks texlive-scheme-full mozilla-fira-sans-fonts texlive-tex-gyre-doc papirus-icon-theme zsh piper -y


