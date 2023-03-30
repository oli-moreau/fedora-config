#!/bin/bash

# Disable idle & power saver options
# Prompt when power button is pressed
configure_power() {
    dconf write /org/gnome/settings-daemon/plugins/power/idle-dim false
    dconf write /org/gnome/desktop/session/idle-delay "uint32 0"
    dconf write /org/gnome/settings-daemon/plugins/power/power-saver-profile-on-low-battery false
    dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type "'nothing'"
    dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-type "'nothing'"
    dconf write /org/gnome/settings-daemon/plugins/power/power-button-action "'interactive'"
}

# Appearance
install_themes() {
    # Theme
    wget -cqO- https://github.com/lassekongo83/adw-gtk3/releases/download/v4.4/adw-gtk3v4-4.tar.xz | sudo tar -xJ -C /usr/share/themes

    # Icons
    wget -c https://github.com/vinceliuice/Tela-icon-theme/archive/refs/heads/master.zip
    unzip master.zip
    Tela-icon-theme-master/install.sh
    rm -rf Tela-icon-theme-master master.zip
}

# Disable network manager wait service
configure_services() {
    sudo systemctl disable NetworkManager-wait-online.service
}

# Configure settings 
configure_environment() {
    # Gnome Tweaks:
    dconf write /org/gnome/mutter/center-new-windows true
    dconf write /org/gnome/desktop/interface/icon-theme "'Tela'"
    dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3-dark'"
    dconf write /org/gnome/desktop/interface/monospace-font-name "'Source Code Pro 12'"
    dconf write /org/gnome/desktop/interface/font-hinting "'full'"
    dconf write /org/gnome/desktop/interface/font-antialiasing "'rgba'"

    # Keyboard layout & shortcuts
    dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'us'), ('xkb', 'ca')]"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/home "['<Super>e']"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Control><Alt>t'"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'kgx'"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'Console'"

    # Search index & results
    dconf write /org/freedesktop/tracker/miner/files/index-recursive-directories "@as []"
    dconf write /org/gnome/desktop/search-providers/disabled "['org.gnome.Contacts.desktop', 'org.gnome.Boxes.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Characters.desktop', 'org.gnome.clocks.desktop', 'firefox.desktop', 'org.gnome.Photos.desktop', 'org.gnome.Software.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop']" 

    # Behaviours
    dconf write /org/gnome/desktop/interface/enable-hot-corners false
    dconf write /org/gnome/shell/app-switcher/current-workspace-only true
    dconf write /org/gnome/desktop/peripherals/touchpad/tap-to-click true

    # File history
    dconf write /org/gnome/desktop/privacy/remember-recent-files false

    # Do nothing if the laptop lid is closed 
    mkdir -p ~/.config/autostart/
    touch ~/.config/autostart/ignore-lid-switch-tweak.desktop
    sed -i -e '$a [Desktop Entry]' \
        -e '$a Type=Application' \
        -e '$a Name=ignore-lid-switch-tweak' \
        -e '$a Exec=/usr/libexec/gnome-tweak-tool-lid-inhibitor' ~/.config/autostart/ignore-lid-switch-tweak.desktop


    # Dock setup
    dconf write /org/gnome/shell/favorite-apps "['firefox.desktop', 'code.desktop', 'org.gnome.TextEditor.desktop', 'sh.cider.Cider.desktop']"

    # Application list setup
    dconf write /org/gnome/shell/app-picker-layout "[{'org.gnome.Nautilus.desktop': <{'position': <0>}>, 'google-chrome.desktop': <{'position': <1>}>, 'gitkraken.desktop': <{'position': <2>}>, 'blender.desktop': <{'position': <3>}>, 'steam.desktop': <{'position': <4>}>, 'org.gnome.Software.desktop': <{'position': <5>}>, 'com.mattjakeman.ExtensionManager.desktop': <{'position': <6>}>, 'gnome-system-monitor.desktop': <{'position': <7>}>, 'org.gnome.Settings.desktop': <{'position': <8>}>, 'org.gnome.Terminal.desktop': <{'position': <9>}>, 'org.gnome.tweaks.desktop': <{'position': <10>}>, 'Utilities': <{'position': <11>}>}]"
    dconf write /org/gnome/desktop/app-folders/folders/Utilities/apps "['gnome-abrt.desktop', 'gnome-system-log.desktop', 'nm-connection-editor.desktop', 'org.gnome.baobab.desktop', 'org.gnome.Connections.desktop', 'org.gnome.DejaDup.desktop', 'org.gnome.Dictionary.desktop', 'org.gnome.DiskUtility.desktop', 'org.gnome.eog.desktop', 'org.gnome.Evince.desktop', 'org.gnome.FileRoller.desktop', 'org.gnome.fonts.desktop', 'org.gnome.seahorse.Application.desktop', 'org.gnome.Usage.desktop', 'vinagre.desktop', 'libreoffice-writer.desktop', 'vlc.desktop', 'yelp.desktop', 'org.gnome.Cheese.desktop', 'com.github.GradienceTeam.Gradience.desktop', 'simple-scan.desktop', 'org.gnome.Totem.desktop', 'org.fedoraproject.MediaWriter.desktop', 'org.gnome.Photos.desktop', 'nl.hjdskes.gcolor3.desktop', 'transmission-gtk.desktop', 'filezilla.desktop', 'ca.desrt.dconf-editor.desktop', 'org.gnome.Calculator.desktop']"
}
