#!/bin/bash

# Upgrade system
echo -e "\e[34mUpdate system\e[m"
pacman -Syu --noconfirm

# Install ansible
which ansible >/dev/null 2>/dev/null || (
    echo -e "\e[34mInstall ansible\e[m"
    pacman -S --noconfirm ansible
)

# Provisioning
echo -e "\e[34mExecute ansible playbook\e[m"
(
    cd /vagrant
    ansible-playbook playbook.yml --connection=local
)
