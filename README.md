# DevOps Machine Setup 🚀

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ansible Lint](https://img.shields.io/badge/ansible--lint-passing-brightgreen)](https://github.com/ansible/ansible-lint)

An open-source Ansible playbook that automates the installation and configuration of essential DevOps tools on Ubuntu systems. Set up your development environment in minutes with a single command!

> **Originally developed by [Clouddrove](https://clouddrove.com), now open-source and community-driven.**

## ✨ Features

- 🎯 **One-Command Setup**: Install 20+ DevOps tools with `make setup`
- 🧩 **Modular Design**: Well-organized Ansible roles for easy customization
- 🔒 **Secure**: GPG key verification for all packages
- 📚 **Well Documented**: Comprehensive guides for beginners and experts
- 🧪 **Tested**: Linted, tested, and production-ready
- 🎓 **Beginner Friendly**: Clear documentation and helpful error messages

## 🛠️ What Gets Installed?

### DevOps Tools
- **Git** - Version control (configured with your details)
- **Docker & Docker Compose** - Container platform
- **AWS CLI v2** - Amazon Web Services CLI
- **Azure CLI** - Microsoft Azure cloud management
- **GCP CLI (gcloud)** - Google Cloud Platform CLI
- **Kubectl** - Kubernetes command-line tool
- **Helm** - Kubernetes package manager
- **k9s** - Kubernetes terminal UI
- **Terraform** - Infrastructure as code (via tfswitch)
- **Ansible** - Automation and configuration management
- **Visual Studio Code** - Industry-standard code editor
- **Lens** - Kubernetes IDE

### Web Browsers
- **Google Chrome** - Web browser
- **Brave Browser** - Privacy-focused browser
- **Tor Browser** - Anonymous browsing

### Communication Tools
- **Slack** - Team collaboration
- **Zoom** - Video conferencing
- **Telegram** - Messaging app
- **Discord** - Developer communities
- **Microsoft Teams** - Enterprise communication

### System Configuration
- **SSH Keys** - Secure shell authentication
- **Oh My Zsh** - Enhanced Zsh shell with plugins

## 📋 Prerequisites

- **Operating System**: Ubuntu 20.04 or later
- **Permissions**: Sudo/root access
- **Internet**: Active internet connection
- **Ansible**: Will be auto-installed if missing (via Makefile)

> **🍎 Using macOS?** This playbook requires Ubuntu Linux. See [TESTING_ON_MAC.md](TESTING_ON_MAC.md) for testing options using VMs or containers.

## 🚀 Quick Start

### Option 1: Using Makefile (Recommended)

```bash
# Clone the repository
git clone <repository-url>
cd machine-setup

# Run setup (handles everything automatically)
make setup
```

That's it! The Makefile will:
- Check and install Ansible if needed
- Verify your system
- Run the playbook
- Guide you through the setup

### Option 2: Manual Installation

```bash
# 1. Install Ansible
sudo apt update
sudo apt install -y ansible

# 2. Run the playbook
ansible-playbook -i ./inventories/hosts.ini ./playbooks/tools_setup.yml
```

### What to Expect

During setup, you'll be prompted for:
1. **Git Username** - Your Git username (e.g., `john.doe`)
2. **Git Email** - Your Git email address (e.g., `john.doe@example.com`)

**Note**: Your hostname will be automatically generated as `DEV-{random_number}` (e.g., `DEV-45678`). You can customize this by setting the `hostname_prefix` variable.

## 📖 Available Commands

The project includes a Makefile with helpful commands:

```bash
make help              # Show all available commands
make setup            # Run the Ansible playbook (main command)
make lint             # Run ansible-lint on all files
make syntax-check     # Check playbook syntax
make test             # Run all tests (lint + syntax)
make install-pre-commit  # Install pre-commit hooks
make run-pre-commit   # Run pre-commit on all files
make clean           # Clean up temporary files
make info            # Display system information

# Testing on Mac (see TESTING_ON_MAC.md)
make test-multipass  # Test using Multipass (easiest)
make test-docker     # Test using Docker
make test-vagrant    # Test using Vagrant
make test-help       # Show testing options
```

## ⚙️ Customization

### Custom Hostname Prefix

By default, hostnames are set as `DEV-{random_number}`. To use a custom prefix:

```bash
ansible-playbook -i ./inventories/hosts.ini ./playbooks/tools_setup.yml -e hostname_prefix=MYORG
```

### Selective Installation

You can install only specific tools using tags:

```bash
# Only install DevOps tools
ansible-playbook -i ./inventories/hosts.ini ./playbooks/tools_setup.yml --tags devops-tools

# Only install browsers
ansible-playbook -i ./inventories/hosts.ini ./playbooks/tools_setup.yml --tags web-browsers

# Only install communication tools
ansible-playbook -i ./inventories/hosts.ini ./playbooks/tools_setup.yml --tags communication-tools
```

### Configure Browsers

Edit `roles/browsers/defaults/main.yml` to select which browsers to install:

```yaml
browsers:
  - chrome
  # - brave  # Comment out to skip
  # - tor    # Comment out to skip
```

## 📁 Project Structure

```
machine-setup/
├── Makefile                 # Main commands (make setup, make lint, etc.)
├── playbooks/
│   └── tools_setup.yml     # Main Ansible playbook
├── roles/                   # Ansible roles (modular components)
│   ├── devops/             # DevOps tools (Git, Docker, AWS, etc.)
│   ├── browsers/           # Web browsers
│   ├── communication-tools/ # Slack, Zoom, Telegram
│   └── system-configuration/ # SSH Keys, Oh My Zsh
├── inventories/
│   └── hosts.ini           # Inventory file (target hosts)
├── .ansible-lint           # Ansible lint configuration
├── .pre-commit-config.yaml # Pre-commit hooks
├── requirements.yml        # Ansible collections requirements
└── .github/
    └── workflows/          # GitHub Actions CI/CD
```

## ⏱️ Installation Time

- **Fast internet**: ~15 minutes
- **Slow internet**: ~30 minutes

The playbook shows progress for each tool being installed.

## 🎓 Learning Resources

### For Beginners

- 📖 **[QUICKSTART.md](QUICKSTART.md)** - Step-by-step guide with troubleshooting
- 📚 **[CONTRIBUTING.md](CONTRIBUTING.md)** - Learn how to contribute
- 💡 Run `make help` to see all available commands

### For Advanced Users

- 🔧 **[CODE_REVIEW.md](CODE_REVIEW.md)** - Technical documentation and architecture
- 🧪 Customize roles in `roles/*/defaults/main.yml`
- 🏗️ Modify tasks in `roles/*/tasks/main.yml`

## 🆘 Troubleshooting

### Common Issues

**Issue**: "Ansible not found"
```bash
# Solution: Install Ansible
sudo apt update && sudo apt install -y ansible
```

**Issue**: "Permission denied"
```bash
# Solution: Make sure you have sudo access
sudo make setup
```

**Issue**: "Connection refused"
```bash
# Solution: Check inventories/hosts.ini
# Should contain: localhost ansible_connection=local
```

**Issue**: Installation takes too long
```bash
# This is normal! The playbook downloads many tools.
# Be patient, it typically takes 15-30 minutes.
```

### Getting Help

- 📖 Check [QUICKSTART.md](QUICKSTART.md) for detailed troubleshooting
- 🐛 [Open an issue](.github/ISSUE_TEMPLATE/bug_report.md) if you find a bug
- 💬 Ask questions in discussions
- 📧 For security issues, see [SECURITY.md](SECURITY.md)

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

Quick contribution steps:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run `make lint` and `make test`
5. Submit a pull request

## 🔒 Security

- 🔐 All packages use GPG key verification
- 🛡️ Only official package sources are used
- 🔑 SSH keys generated with secure defaults (RSA 4096)
- 🧹 Temporary files are cleaned up after installation

For security concerns, please see [SECURITY.md](SECURITY.md).

## 📝 Code Quality

This project maintains high code quality standards:

- ✅ **Ansible Lint**: All code is linted
- ✅ **Pre-commit Hooks**: Automatic checks on commit
- ✅ **GitHub Actions**: CI/CD pipeline for testing
- ✅ **Best Practices**: Follows Ansible conventions

Run `make lint` to check code quality locally.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Originally developed by [Clouddrove](https://clouddrove.com)
- Built with [Ansible](https://www.ansible.com/)
- Community-driven and open-source

## 📊 Project Status

- ✅ **Production Ready**: Tested and stable
- ✅ **Open Source**: MIT Licensed
- ✅ **Maintained**: Active development
- ✅ **Documented**: Comprehensive guides

## 🌟 Star History

If you find this project useful, please consider giving it a ⭐ on GitHub!

---

**Made with ❤️ by the open-source community**

For questions, suggestions, or contributions, please open an issue or pull request!
