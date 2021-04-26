#!/bin/bash

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

pacman -S --noconfirm grub efibootmgr networkmanager zsh sudo nano intel-ucode ntfs-3g bluez firewalld

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable firewalld
systemctl enable fstrim.timer

useradd -m gabriel
echo gabriel:password | chpasswd
echo "gabriel ALL=(ALL) ALL" >> /etc/sudoers

sed -i '92s/.//' /etc/pacman.conf
sed -i '93s/.//' /etc/pacman.conf
pacman -Syu --noconfirm

pacman -S --noconfirm eog evince file-roller gdm gedit gnome-backgrounds gnome-calculator gnome-control-center gnome-keyring gnome-shell gnome-system-monitor gnome-weather nautilus gnome-tweaks chrome-gnome-shell alacarte tilix firefox discord steam inkscape freecad nvidia nvidia-settings texlive-most papirus-icon-theme ttf-fira-sans tex-gyre-fonts base-devel

systemctl enable gdm
