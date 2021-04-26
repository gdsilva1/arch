#!/bin/bash

# Configurações básicas - https://wiki.archlinux.org/index.php/Installation_guide_(Português)

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
sed -i '393s/.//' /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost.localdomain localhost" >> /etc/hosts
echo "::1 localhost.localdomain localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

# Instalando pacotes necessários: 
#   - inicialização do sistema (grub, efibootmgr, ntfs-3g, os-prober);
#   - gerenciador de internet (networkmanager);
#   - gerenciador de bluetooth (bluez);
#   - firewall (firewalld);
#   - interpretador de terminal (zsh);
#   - administrador do sistema (sudo);
#   - editor de texto via terminal (nano);
#   - atualização de microcódigo (intel-ucode ou amd-ucode).

pacman -S --noconfirm grub efibootmgr ntfs-3g os-prober networkmanager bluez firewalld zsh sudo nano intel-ucode 

# Instalando e configurando a incialização do sistema

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch --recheck
grub-mkconfig -o /boot/grub/grub.cfg

# Habilitando serivços

systemctl enable NetworkManager # Gerenciador de internet
systemctl enable bluetooth # Gerenciador de bluetooth
systemctl enable firewalld # Firewall
systemctl enable fstrim.timer # Manutenção de SSD

# Criando usuário e tornando-o administrador do sistema
# OBS.: a senha padrão será "admin", a qual deverá ser alterada após a completa instalação do sistema

useradd -m gabriel
echo gabriel:admin | chpasswd
echo "gabriel ALL=(ALL) ALL" >> /etc/sudoers

# Habilitando o repositório multilib

sed -i '92s/.//' /etc/pacman.conf
sed -i '93s/.//' /etc/pacman.conf
pacman -Syu --noconfirm

# Instalando o GNOME e outros softwares

pacman -S --noconfirm eog evince file-roller gdm gedit gnome-backgrounds gnome-calculator gnome-control-center gnome-keyring gnome-shell gnome-system-monitor gnome-weather nautilus gnome-tweaks chrome-gnome-shell alacarte tilix firefox discord steam inkscape freecad nvidia nvidia-settings texlive-most papirus-icon-theme ttf-fira-sans tex-gyre-fonts base-devel

# Habilitando a tela de login (GNOME Display Manager)

systemctl enable gdm
