#!/bin/bash

# Configurações básicas - https://wiki.archlinux.org/index.php/Installation_guide_(Português)

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
sed -i '394s/.//' /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "legion" >> /etc/hostname
echo "127.0.0.1 localhost.localdomain localhost" >> /etc/hosts
echo "::1 localhost.localdomain localhost" >> /etc/hosts
echo "127.0.1.1 legion.localdomain legion" >> /etc/hosts

# Instalando pacotes necessários: 
#   - inicialização do sistema (grub, efibootmgr, ntfs-3g, os-prober);
#   - gerenciador de internet (networkmanager);
#   - gerenciador de bluetooth (bluez, bluez-utils);
#   - firewall (firewalld);
#   - interpretador de terminal (zsh);
#   - administrador do sistema (sudo);
#   - editor de texto via terminal (nano);
#   - atualização de microcódigo (intel-ucode ou amd-ucode).

pacman -S --noconfirm grub efibootmgr ntfs-3g os-prober networkmanager bluez bluez-utils pulseaudio-bluetooth firewalld zsh sudo nano intel-ucode 

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

# Habilitando o repositório multilib e permitindo múltiplos downloads

sed -i '37s/.//' /etc/pacman.conf
sed -i '93s/.//' /etc/pacman.conf
sed -i '94s/.//' /etc/pacman.conf
pacman -Syu --noconfirm

# Instalando softwares

pacman -S --noconfirm firefox discord steam freecad inkscape nvidia nvidia-settings texlive-most ttf-fira-sans tex-gyre-fonts neofetch

# Instalando base-devel para ter acesso ao AUR

pacman -S --needed --noconfirm base-devel
