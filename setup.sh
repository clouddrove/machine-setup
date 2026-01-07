#!/bin/bash

# ============================================================================
# DevOps Machine Setup Script
# ============================================================================
# This script makes it super easy to set up your machine!
# Just run: ./setup.sh
# ============================================================================

set -e

echo "🚀 DevOps Machine Setup"
echo "======================="
echo ""

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "📦 Ansible not found. Installing Ansible..."
    sudo apt update
    sudo apt install -y ansible
    echo "✅ Ansible installed!"
    echo ""
fi

# Check if we're on Ubuntu
if [ ! -f /etc/os-release ]; then
    echo "❌ Error: Cannot detect OS. This script is for Ubuntu only."
    exit 1
fi

# Check if running as root (we don't want that)
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  Warning: Don't run as root. Run as your regular user (sudo will be used when needed)."
    exit 1
fi

echo "✅ Prerequisites check passed!"
echo ""
echo "📋 This will install:"
echo "   - Git, Docker, AWS CLI, Kubectl, Helm"
echo "   - Terraform, Lens, Browsers, Communication tools"
echo "   - SSH Keys, Oh My Zsh"
echo ""
echo "⏱️  Estimated time: 15-30 minutes"
echo ""
read -p "Press Enter to continue or Ctrl+C to cancel..."

echo ""
echo "🎯 Starting installation..."
echo ""

# Run the playbook
ansible-playbook -i ./inventories/hosts.ini ./playbooks/tools_setup.yml

echo ""
echo "🎉 Installation complete!"
echo ""
echo "📝 Next steps:"
echo "   1. Restart your terminal or run: source ~/.zshrc"
echo "   2. Verify installations with: git --version, docker --version, etc."
echo ""

