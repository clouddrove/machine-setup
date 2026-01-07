# 🚀 Quick Start Guide for DevOps Interns

This guide will help you set up your Ubuntu machine with all DevOps tools in just 3 steps!

## ✅ Prerequisites

Before you start, make sure you have:
- ✅ Ubuntu Linux (20.04 or later)
- ✅ Internet connection
- ✅ Sudo/root access
- ✅ Ansible installed (if not, see below)

## 📦 Step 1: Install Ansible (if not already installed)

```bash
sudo apt update
sudo apt install -y ansible
```

Verify installation:
```bash
ansible --version
```

## 🎯 Step 2: Clone and Run the Playbook

```bash
# Clone the repository (or navigate to the directory)
cd machine-setup

# Run the playbook
ansible-playbook -i ./inventories/hosts.ini ./playbooks/tools_setup.yml
```

## 💬 Step 3: Answer 2 Simple Questions

The playbook will ask you:

1. **Git Username**: Enter your Git username
   - Example: `john.doe` or `johndoe`

2. **Git Email**: Enter your Git email
   - Example: `john.doe@company.com`

**Note**: Your hostname will be automatically generated as `CD-IN-UB-{random_number}` (e.g., `CD-IN-UB-45678`)

## ⏱️ What Happens Next?

The playbook will automatically install:
- ✅ Git (with your config)
- ✅ Docker & Docker Compose
- ✅ AWS CLI
- ✅ Kubectl & Helm
- ✅ Terraform (via tfswitch)
- ✅ Lens (Kubernetes IDE)
- ✅ Browsers (Chrome, Brave, Tor)
- ✅ Communication tools (Slack, Zoom, Telegram)
- ✅ SSH Keys
- ✅ Oh My Zsh

**Time required**: 15-30 minutes (depending on internet speed)

## 🎉 After Installation

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Verify installations**:
   ```bash
   git --version
   docker --version
   aws --version
   kubectl version --client
   helm version
   ```

## 🆘 Troubleshooting

### Issue: "Permission denied"
**Solution**: Make sure you're running with sudo or have sudo access
```bash
sudo ansible-playbook -i ./inventories/hosts.ini ./playbooks/tools_setup.yml
```

### Issue: "Ansible not found"
**Solution**: Install Ansible first (see Step 1)

### Issue: "Connection refused"
**Solution**: Make sure you're running on localhost. Check `inventories/hosts.ini`:
```ini
[local]
localhost ansible_connection=local
```

### Issue: Installation takes too long
**Solution**: This is normal! The playbook downloads and installs many tools. Be patient.

## 📚 Need Help?

- Check the main [README.md](README.md) for detailed information
- Ask your mentor or team lead
- Review the playbook logs for specific errors

## 🎓 What You'll Learn

By using this playbook, you'll learn:
- How Ansible automates infrastructure setup
- How to use playbooks and roles
- How DevOps tools are installed and configured
- Best practices for machine setup

---

**Happy Learning! 🚀**

