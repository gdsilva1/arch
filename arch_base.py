import os
import shutil
import getpass

def statement(t):
    print(t)
    print("-"*len(t))
    input("Pressione qualquer tecla para continuar...")

# Basic configuration
statement("Iniciando as configurações básicas do sistema.")
os.system("ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime")
os.system("hwclock --systohc")

with open("/etc/locale.gen", "a") as file:
    file.write("en_US.UTF-8 UTF-8")
    file.write("pt_BR.UTF-8 UTF-8")

os.system("locale-gen")

with open("/etc/locale.conf", "a") as file:
    file.write("LANG=pt_BR.UTF-8")

with open("/etc/vconsole.conf", "a") as file:
    file.write("KEYMAP=br-abnt2")

with open("/etc/hostname", "a") as file:
    file.write("arch")

with open("/etc/hosts", "a") as file:
    file.write("127.0.0.1 localhost.localdomain localhost")
    file.write("::1 localhost.localdomain localhost")
    file.write("127.0.1.1 arch.localdomain arch")

# Pacman configuration
statement("Configurando o pacman.")
shutil.move("/etc/pacman.conf", "/etc/pacman.conf.backup")
shutil.copy("./pacman.conf", "/etc/")
os.system("pacman -Syu --noconfirm")

# Essential packages
statement("Instalando os principais pacotes e configurando o GRUB.")
os.system("pacman -S --noconfirm grub efibootmgr ntfs-3g os-prober networkmanager bluez bluez-utils pulseaudio-bluetooth firewalld fish sudo intel-ucode")

# Grub configuration
os.system("grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch --recheck")
os.system("grub-mkconfig -o /boot/grub/grub.cfg")

# User configuration
statement("Configurando o usuário.")
user = input("Username: ")
password = getpass.getpass("Password: ")

os.system(f"useradd -m {user}")
os.system(F"{user}:{password} | chpasswd")

with open("/etc/sudoers", "a") as file:
    file.write(f"{user} ALL=(ALL) ALL")

# Usefull packages
statement("Pacotes adicionais")
os.system("pacman -S --noconfirm firefox steam inkscape nvidia nvidia-settings")

# Base-devel to AUR acess
statement("AUR")
os.system("pacman -S --needed --noconfirm base-devel")