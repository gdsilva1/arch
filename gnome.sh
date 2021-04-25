#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost.localdomain localhost" >> /etc/hosts
echo "::1 localhost.localdomain localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

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

pacman -S --noconfirm eog evince file-roller gdm gedit gnome-backgrounds gnome-calculator gnome-control-center gnome-keyring gnome-session gnome-settings-daemon gnome-shell gnome-system-monitor gnome-weather nautilus flameshot tilix

systemctl enable gdm
