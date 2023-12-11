# DevOps Tools Setup

Prepared by Clouddrove, this Ansible role is meticulously designed to facilitate the seamless setup of your machine with a suite of essential DevOps tools.

The playbook is primed for execution on the local host, ensuring a swift and hassle-free environment setup.

Currently, it is optimized for Ubuntu-based Linux distributions.

## Included Tools

The playbook automates the installation of the following tools:

| DevOps Tools       | Description                                                  |
|--------------------|--------------------------------------------------------------|
| Git                | Version control system                                       |
| Docker             | Container platform                                           |
| Docker-compose     | Tool for defining and running multi-container Docker apps    |
| AWS CLI            | Command-line interface for Amazon Web Services               |
| Terraform          | Infrastructure as code software tool                         |
| Kubectl            | Command-line tool for Kubernetes                             |
| Helm               | Package manager for Kubernetes                               |
| VS Code            | Source-code editor                                           |
| Chrome             | Web browser                                                  |
| Brave              | Privacy-focused web browser                                  |
| Tor                | Browser for anonymous web browsing                           |
| Telegram           | Messaging app                                                |
| Zoom               | Video conferencing tool                                      |
| Slack              | Collaboration hub for work                                   |
| Minikube           | Tool to run Kubernetes locally                               |
| Lens               | Kubernetes IDE                                               |
| SSH Keys           | Secure shell keys for authentication                         |

## Prerequisite Packages

In addition to the tools, the playbook installs the following prerequisite packages:

| Prerequisite Packages         | Purpose                                          |
|-------------------------------|--------------------------------------------------|
| ca-certificates               | Common CA certificates                           |
| apt-transport-https            | Transport for APT over HTTPS                     |
| lsb-release                   | Provides information about the Linux distribution|
| gnupg                         | GNU Privacy Guard for encryption                 |
| bash-completion               | Programmable completion for Bash                 |
| gnupg2                        | GNU Privacy Guard version 2                      |
| curl                          | Tool for transferring data with URLs             |
| software-properties-common    | Manage the repositories that you install software from |
| virtualenv                    | Tool to create isolated Python environments      |
| python3-setuptools            | Easily build and distribute Python packages      |
| unzip                         | Unpacks ZIP files                                |
| libxtst6                      | Library for the X11 Testing -- Resource extension|
| libx11-xcb1                   | X11 client-side library                         |
| libxcb-dri3-0                 | X11 Direct Rendering Infrastructure             |
| libasound2                    | Shared library for ALSA applications             |
| libssl-dev                    | Development files for SSL libraries             |
| htop                          | Interactive process viewer                       |
| openssh-server                | Secure shell server for secure access from remote machines |

## Getting Started

To utilize this playbook:

1. Clone this repository to your local machine.
2. Navigate to `inventories/vars.yml` and update the variables to match your configuration:

    ```yaml
    git_user: "your_username"
    git_email: "your_email@example.com"
    ssh_user: "your_username"
    ```

3. Execute the playbook from the terminal with the following command:

    ```bash
    ansible-playbook -i ./inventories/hosts.ini ./playbook/machine-setup.yml
    ```

Enjoy the streamlined setup of your DevOps environment!
