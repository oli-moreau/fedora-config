#!/bin/bash

source lib/prompt.sh
source lib/packages.sh
source lib/environment.sh

config_start

configure_power
update_system
add_repos
install_packages
install_packages_remote
install_dev_tools
install_themes
configure_services
configure_environment

config_end
