#!/bin/bash

# Update the system
update_system() {
    sudo dnf check-update
    sudo dnf upgrade -y
}

# Add RPM Fusion and Flathub
add_repos() {
    wget -c https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-38.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-38.noarch.rpm
    sudo dnf install -y ./rpmfusion-free-release-38.noarch.rpm
    sudo dnf install -y ./rpmfusion-nonfree-release-38.noarch.rpm
    rm -f rpmfusion-*
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

# Remove unused packages & install what is needed
install_packages() {
    sudo dnf remove -y libreoffice* rhythmbox gnome-contacts gnome-weather gnome-maps gnome-tour gnome-boxes gnome-calendar gnome-clocks
    sudo dnf install -y gnome-tweaks gnome-console transmission-gtk filezilla gcolor3 libreoffice-writer vlc intel-media-driver steam blender php
    flatpak install -y com.github.GradienceTeam.Gradience sh.cider.Cider com.mattjakeman.ExtensionManager
}

# Install packages from remote repos
install_packages_remote() {    
    wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    sudo dnf install -y ./google-chrome-stable_current_x86_64.rpm
    rm google*.rpm
}

# Install VSCode, GitKraken, NodeJS, Composer
install_dev_tools() {
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    dnf check-update
    sudo dnf install -y code

    wget -c https://release.axocdn.com/linux/gitkraken-amd64.rpm
    sudo dnf install -y ./gitkraken-amd64.rpm
    rm gitkraken*.rpm

    sudo dnf install -y nodejs

    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    sudo mv composer.phar /usr/bin/composer
}
