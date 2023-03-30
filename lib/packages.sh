#!/bin/bash

# Update the system
update_system() {
    sudo dnf check-update
    sudo dnf upgrade -y
}

# Add RPM Fusion and Flathub
add_repos() {
    wget -c https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-branched.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-branched.noarch.rpm
    sudo dnf install -y ./rpmfusion-free-release-branched.noarch.rpm
    sudo dnf install -y ./rpmfusion-nonfree-release-branched.noarch.rpm
    rm -f rpmfusion-*
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

# Remove unused packages & install what is needed
install_packages() {
    sudo dnf remove -y libreoffice* rhythmbox gnome-contacts gnome-weather gnome-maps gnome-tour gnome-boxes gnome-calendar gnome-clocks
    sudo dnf install -y gnome-tweaks gnome-console transmission-gtk filezilla gcolor3 libreoffice-writer vlc intel-media-driver steam blender
    flatpak install -y com.github.GradienceTeam.Gradience sh.cider.Cider com.mattjakeman.ExtensionManager
}

# Install packages from remote repos
install_packages_remote() {    
    wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    sudo dnf install -y ./google-chrome-stable_current_x86_64.rpm
    rm google*.rpm
}

# Install VSCode, GitKraken, NodeJS
install_dev_tools() {
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    dnf check-update
    sudo dnf install -y code

    wget -c https://release.axocdn.com/linux/gitkraken-amd64.rpm
    sudo dnf install -y ./gitkraken-amd64.rpm
    rm gitkraken*.rpm

    sudo dnf install -y nodejs
}
