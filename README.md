# DevOps Tools Setup 🛠️

Prepared by Clouddrove, this Ansible role is meticulously designed to facilitate the seamless setup of your machine with a suite of essential DevOps tools. 🚀

The playbook is primed for execution on the local host, ensuring a swift and hassle-free environment setup. 💻

Currently, it is optimized for Ubuntu-based Linux distributions. 🐧

## Included Tools 🧰

The playbook automates the installation of the following tools:

| DevOps Tools       | Description                                                  |
|--------------------|--------------------------------------------------------------|
| Git                | Version control system 📝                                    |
| Docker             | Container platform 🐳                                        |
| Docker-compose     | Tool for defining and running multi-container Docker apps 📦 |
| AWS CLI            | Command-line interface for Amazon Web Services ☁️            |
| Terraform          | Infrastructure as code software tool 🏗️                      |
| Kubectl            | Command-line tool for Kubernetes ⚙️                           |
| Helm               | Package manager for Kubernetes 📦                             |
| Chrome             | Web browser 🌐                                               |
| Brave              | Privacy-focused web browser 🛡️                               |
| Tor                | Browser for anonymous web browsing 🕵️‍♂️                     |
| Telegram           | Messaging app 📱                                             |
| Zoom               | Video conferencing tool 📹                                   |
| Slack              | Collaboration hub for work 💬                                |
| Lens               | Kubernetes IDE 🔍                                             |
| SSH Keys           | Secure shell keys for authentication 🔑                       |
| Oh My Zsh          | Interactive shell tool for managing Zsh configuration 🖥️     |


## Prerequisite Packages 📦

In addition to the tools, the playbook installs the following prerequisite packages:

| Prerequisite Packages         | Purpose                                          |
|-------------------------------|--------------------------------------------------|
| ca-certificates               | Common CA certificates 🔒                        |
| apt-transport-https            | Transport for APT over HTTPS 🔐                  |
| lsb-release                   | Provides information about the Linux distribution📦|
| gnupg                         | GNU Privacy Guard for encryption 🔐              |
| bash-completion               | Programmable completion for Bash 🖥️              |
| gnupg2                        | GNU Privacy Guard version 2 🔐                   |
| curl                          | Tool for transferring data with URLs 🌐          |
| software-properties-common    | Manage the repositories that you install software from 🛠️ |
| virtualenv                    | Tool to create isolated Python environments 🐍   |
| python3-setuptools            | Easily build and distribute Python packages 📦   |
| unzip                         | Unpacks ZIP files 📂                             |
| libxtst6                      | Library for the X11 Testing -- Resource extension🖥️|
| libx11-xcb1                   | X11 client-side library 🖥️                       |
| libxcb-dri3-0                 | X11 Direct Rendering Infrastructure 🖥️          |
| libasound2                    | Shared library for ALSA applications 🔊          |
| libssl-dev                    | Development files for SSL libraries 🔐           |
| htop                          | Interactive process viewer 📊                     |
| openssh-server                | Secure shell server for secure access from remote machines 🔐 |

## Getting Started 🌟

### For Beginners (Easiest Way)

**Just run one command:**
```bash
./setup.sh
```

That's it! The script will handle everything.

### Manual Setup (If you prefer)

1. **Install Ansible** (if not already installed):
   ```bash
   sudo apt update
   sudo apt install -y ansible
   ```

2. **Run the playbook**:
   ```bash
   ansible-playbook -i ./inventories/hosts.ini ./playbooks/tools_setup.yml
   ```

3. **Answer 2 simple questions**:
   - Your Git username (e.g., `john.doe`)
   - Your Git email (e.g., `john.doe@company.com`)

**Note**: Hostname is automatically generated as `CD-IN-UB-{random_number}` (e.g., `CD-IN-UB-45678`)

### 📖 New to Ansible?

Check out our **[QUICKSTART.md](QUICKSTART.md)** guide for step-by-step instructions!

## What Gets Installed? 🧰

The playbook automatically installs all these tools:

**DevOps Tools:**
- Git (configured with your details)
- Docker & Docker Compose
- AWS CLI v2
- Kubectl & Helm
- Terraform (via tfswitch)
- Lens (Kubernetes IDE)

**Browsers:**
- Google Chrome
- Brave Browser
- Tor Browser

**Communication:**
- Slack
- Zoom
- Telegram

**System:**
- SSH Keys
- Oh My Zsh (with plugins)

## ⏱️ Installation Time

- **Fast internet**: ~15 minutes
- **Slow internet**: ~30 minutes

The playbook will show progress for each tool being installed.

## 🆘 Need Help?

- 📖 Read [QUICKSTART.md](QUICKSTART.md) for detailed guide
- 🔍 Check playbook output for specific errors
- 💬 Ask your mentor or team lead

Enjoy the streamlined setup of your DevOps environment! 🚀

