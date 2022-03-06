#!/bin/bash

# Configurações básicas - https://wiki.archlinux.org/index.php/Installation_guide_(Português)

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
sed -i '394s/.//' /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost.localdomain localhost" >> /etc/hosts
echo "::1 localhost.localdomain localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

# Configuração do pacman
mv /etc/pacman.conf /etc/pacman.conf.backup
cp pacman.conf /etc/
pacman -Syu --noconfirm

# Instalando pacotes necessários: 
#   - inicialização do sistema (grub, efibootmgr, ntfs-3g, os-prober);
#   - gerenciador de internet (networkmanager);
#   - gerenciador de bluetooth (bluez, bluez-utils, pulseaudio-bluetooth);
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

systemctl enable --now NetworkManager # Gerenciador de internet
systemctl enable --now bluetooth      # Gerenciador de bluetooth
systemctl enable --now firewalld       # Firewall
systemctl enable --now fstrim.timer   # Manutenção de SSD

# Criando usuário e tornando-o administrador do sistema
# OBS.: a senha padrão será "admin", altere de preferência antes de executar o script

useradd -m user
echo user:admin | chpasswd
echo "user ALL=(ALL) ALL" >> /etc/sudoers

# Habilitando o repositório multilib e permitindo múltiplos downloads

# sed -i '33s/.//' /etc/pacman.conf
# sed -i '37s/.//' /etc/pacman.conf
# sed -i '93s/.//' /etc/pacman.conf
# sed -i '94s/.//' /etc/pacman.conf
# pacman -Syu --noconfirm

# Instalando softwares

pacman -S --noconfirm firefox discord steam freecad inkscape nvidia nvidia-settings texlive-most tex-gyre-fonts neofetch

# Instalando base-devel para ter acesso ao AUR

pacman -S --needed --noconfirm base-devel
