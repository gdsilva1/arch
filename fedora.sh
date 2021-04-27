#!/bin/bash

# Adicionando respositórios mais rápidos

echo "fastestmirror=true" >> /etc/dnf/dnf.conf
echo "deltarpm=true" >> /etc/dnf/dnf.conf

# Atualizando o sistema (útil principalmente se a instalação não for feita pela ISO do Fedora Server)

sudo dnf -y update 
sudo dnf -y upgrade

# Adicionando repositório do RPM Fusion

sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf -y groupupdate core

sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf -y groupupdate sound-and-video

# Adicionando repositórios fo Flathub

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalando pacotes em Flatpak

flatpak install flathub com.spotify.Client -y
flatpak install flathub com.discordapp.Discord -y

# Instalando pacotes do repositório

sudo dnf -y install steam freecad inkscape gnome-tweaks texlive-scheme-full mozilla-fira-sans-fonts texlive-tex-gyre-doc papirus-icon-theme zsh piper


