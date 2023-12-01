# Machine Tools  Setup


Ansible repo designed to set up machine with necessary Dev(Ops) tooling.
Included various browsers, spotify and calibre for convenience.  

Assumed that the playbook will run against local host.

For now, this is will be targeted for ubuntu-based linux distros.

The playbook currently installs the following:

* Git
* Docker
* Docker-compose
* Azure CLI
* AWS CLI
* Bash-it
* Terraform
* Kubectl
* Helm
* VS Code
* Molecule (in virtualenv)
* Multiboot
* Chrome
* Brave
* Tor
* Spotify
* Telegram
* Zoom
* Slack
* 



## Getting Started

1. Clone this repo to your local disk.
2. Change the encrypted group vars to include your git variables (see git role defaults).
3. Open in terminal, and run:

    `make install`