# Script de configuração para Arch Linux

Automatizando o processo de *configuração* descrito em https://wiki.archlinux.org/title/Installation_guide_(Português).

## Tutorial

1. Particione os discos, formate-os e instale o sistema base.
2. Quando estiver dentro do sistema base, i.e., após o comando ```arch-chroot /mnt``` mencionado no guia de instalação, instale o pacote ```git``` e baixe este repositório.
3. Se necessário, configure o arquivo ```arch_base.sh``` e ```pacman.conf``` (necessário um editor de texto via terminal como vim ou nano).
4. Torne o script executavel com o comando ```chmod +x arch_base.sh```.
5. Rode o scritp com o comando ```./arch_base.sh```

Após isso, o sistema estará configurado. Note que:
- nenhuma DE estará instalada;
- o repositório para o MEGASync estar
- o usuário padrão será *user*; e
- a senha será ```admin```.

Para mudar estas configurações padrões é mandatório editar os arquivos mencionados no passo 3.
