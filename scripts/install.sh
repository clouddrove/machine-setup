#!/bin/bash
USERNAME=$(whoami)
RUN_PLAYBOOK=${1:-"no"}
if [[ -z $2 ]]; then
    TAGS=""
else
    TAGS="--tags $1"
fi

function check_user() {
     user=${1:-"$(whoami)"}
     echo "USER: ${user}"
     if [[ $user ==  'root' ]]; then
          echo -e "ERROR, user is root!\nRe-run Make install without sudo!"
          exit 1
     fi
}

function apt_dependencies() {
     sudo apt-get update
     sudo apt-get upgrade -y
     sudo apt-get install -y python3-pip
}

function pip_dependencies() {
	if ! grep -Fxq ".local/bin" ~/.profile ; then 
          echo "PATH=$PATH:/home/${USERNAME}/.local/bin" >> ~/.profile
     fi
     pip3 install setuptools wheel
     pip3 install virtualenv
     which virtualenv
}

function installer_virtualenv() {
     mkdir -p /home/${user}/.installer
     virtualenv /home/${user}/.installer
     source /home/${user}/.installer/bin/activate
     pip3 install ansible==2.10.3
     pip3 install ansible==2.10.3 six
     ansible --version
}

set -e
if [[ -f /home/${USERNAME}/.local/bin/virtualenv ]]; then
    echo "Virtualenv detected. Skipping init script setup."
    if [[ -f /home/${USERNAME}/.virtualenvs/molecule/bin/activate ]]; then
        echo "Molecule virtualenv detected. Using this for ansible playbook."
        . /home/${USERNAME}/.virtualenvs/molecule/bin/activate
    elif [[ -f /home/${USERNAME}/.installer/bin/activate ]]; then
        echo "Installer virtualenv detected. Using this for ansible playbook."
        . /home/${USERNAME}/.installer/bin/activate
    else
        echo "No virtualenv detected for running ansible playbook."
        echo "Setting up installer virtualenv..."
        installer_virtualenv
	    . /home/${USERNAME}/.installer/bin/activate
	fi
else
    check_user ${USERNAME}
    apt_dependencies
    pip_dependencies
    installer_virtualenv
	. /home/${USERNAME}/.installer/bin/activate
fi

if [[ $RUN_PLAYBOOK == "play" ]]; then
    sudo -k
    ansible-playbook \
        --user ${USERNAME} \
        --inventory inventory/hosts.yaml \
        ${TAGS} \
        --ask-become-pass \
        playbooks/machine_setup.yaml
    rm -rf ~/.installer
fi