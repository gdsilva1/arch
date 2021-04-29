#!/bin/bash

# Adicionando respositórios mais rápidos

echo "fastestmirror=true" >> /etc/dnf/dnf.conf
echo "deltarpm=true" >> /etc/dnf/dnf.conf

# Atualizando o sistema (útil principalmente se a instalação não for feita pela ISO do Fedora Server)

dnf -y update 
dnf -y upgrade

# Adicionando repositório do RPM Fusion

dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf -y groupupdate core

dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf -y groupupdate sound-and-video

# Instalando pacotes do repositório

dnf -y update
dnf -y install akmod-nvidia steam freecad inkscape gnome-tweaks texlive-scheme-full mozilla-fira-sans-fonts texlive-tex-gyre-doc papirus-icon-theme zsh piper snapd

ln -s /var/lib/snapd/snap /snap

snap install code --classic

echo "FIM"


