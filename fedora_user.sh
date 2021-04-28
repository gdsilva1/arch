#!/bin/bash

# Adicionando repositórios do Flathub

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalando pacotes em Flatpak

flatpak install flathub com.spotify.Client -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.visualstudio.code -y

# Adicionando o Oh My Zsh! e Powerlevel10k

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
