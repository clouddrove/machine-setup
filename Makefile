.PHONY: help setup lint install-pre-commit run-pre-commit clean check-ansible check-ubuntu test-help test-multipass test-docker test-vagrant clean-multipass clean-docker clean-vagrant

# Default target
.DEFAULT_GOAL := help

# Variables
INVENTORY := ./inventories/hosts.ini
PLAYBOOK := ./playbooks/tools_setup.yml
ANSIBLE_LINT := ansible-lint
PRE_COMMIT := pre-commit

##@ General

help: ## Display this help message
	@echo "DevOps Machine Setup - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""

##@ Setup

setup: check-ansible check-ubuntu ## Run the Ansible playbook to set up the machine
	@echo "🚀 Starting DevOps Machine Setup..."
	@echo ""
	ansible-playbook -K -i ./inventories/hosts.ini ./playbooks/tools_setup.yml

check-ansible: ## Check if Ansible is installed
	@which ansible > /dev/null || (echo "❌ Ansible not found. Installing..." && sudo apt update && sudo apt install -y ansible)
	@echo "✅ Ansible is installed"

check-ubuntu: ## Check if running on Ubuntu
	@if [ ! -f /etc/os-release ]; then \
		echo "❌ Error: Cannot detect OS. This script is for Ubuntu only."; \
		exit 1; \
	fi
	@if [ "$$(grep -i ubuntu /etc/os-release 2>/dev/null)" = "" ]; then \
		echo "⚠️  Warning: This playbook is designed for Ubuntu"; \
	fi
	@echo "✅ OS check passed"

##@ Code Quality

lint: install-collections ## Run ansible-lint on all playbooks and roles
	@echo "🔍 Running Ansible Lint..."
	@$(ANSIBLE_LINT) --version || (echo "❌ ansible-lint not installed. Install with: pip install ansible-lint" && exit 1)
	@$(ANSIBLE_LINT) --force-color --exclude=molecule/ --exclude=.molecule/ --exclude=.github/
	@echo "✅ Linting complete"

install-collections: ## Install required Ansible collections
	@if [ -f requirements.yml ]; then \
		echo "📦 Installing Ansible collections..."; \
		ansible-galaxy collection install -r requirements.yml 2>/dev/null || echo "⚠️  Collections may already be installed"; \
	fi

lint-playbook: ## Run ansible-lint on the main playbook only
	@echo "🔍 Running Ansible Lint on playbook..."
	@$(ANSIBLE_LINT) --force-color $(PLAYBOOK)

syntax-check: ## Check Ansible playbook syntax
	@echo "🔍 Checking playbook syntax..."
	@ansible-playbook --syntax-check -i $(INVENTORY) $(PLAYBOOK)
	@echo "✅ Syntax check passed"

##@ Pre-commit

install-pre-commit: ## Install pre-commit hooks
	@echo "📦 Installing pre-commit hooks..."
	@pip install pre-commit || (echo "❌ pip not found. Install Python pip first." && exit 1)
	@$(PRE_COMMIT) install
	@echo "✅ Pre-commit hooks installed"

run-pre-commit: ## Run pre-commit on all files
	@echo "🔍 Running pre-commit on all files..."
	@$(PRE_COMMIT) run --all-files

update-pre-commit: ## Update pre-commit hooks to latest versions
	@echo "🔄 Updating pre-commit hooks..."
	@$(PRE_COMMIT) autoupdate

##@ Testing

test: lint syntax-check ## Run all tests (lint + syntax check)
	@echo "✅ All tests passed"

##@ Cleanup

clean: ## Clean up temporary files and caches
	@echo "🧹 Cleaning up temporary files..."
	@rm -rf .ansible-lint-cache
	@rm -rf __pycache__ .pytest_cache
	@rm -rf .molecule
	@find . -type f -name "*.retry" -delete
	@find . -type f -name ".DS_Store" -delete
	@echo "✅ Cleanup complete"

##@ Information

info: ## Display system and project information
	@echo "📋 System Information:"
	@echo "  OS: $$(grep PRETTY_NAME /etc/os-release 2>/dev/null | cut -d'"' -f2 || echo 'Unknown')"
	@echo "  Ansible: $$(ansible --version 2>/dev/null | head -n1 || echo 'Not installed')"
	@echo "  Ansible Lint: $$($(ANSIBLE_LINT) --version 2>/dev/null | head -n1 || echo 'Not installed')"
	@echo "  Python: $$(python3 --version 2>/dev/null || echo 'Not installed')"
	@echo ""
	@echo "📁 Project Structure:"
	@echo "  Playbook: $(PLAYBOOK)"
	@echo "  Inventory: $(INVENTORY)"
	@echo "  Roles: $$(ls -d roles/*/ 2>/dev/null | wc -l) roles"

test-help: ## Show testing options (for Mac users)
	@echo "🍎 Testing on macOS"
	@echo "=================="
	@echo ""
	@echo "This playbook requires Ubuntu Linux."
	@echo "To test on Mac, see: TESTING_ON_MAC.md"
	@echo ""
	@echo "Quick options:"
	@echo "  make test-multipass  # Using Multipass (easiest)"
	@echo "  make test-docker     # Using Docker"
	@echo "  make test-vagrant    # Using Vagrant"
	@echo ""

##@ Testing on Mac

test-multipass: ## Test using Multipass (recommended for Mac)
	@echo "🚀 Setting up Multipass VM for testing..."
	@echo ""
	@echo "Creating Ubuntu 22.04 VM..."
	@multipass launch 22.04 --name devops-test --mem 4G --disk 20G --cpus 2 || \
		(echo "⚠️  VM might already exist. Use: multipass shell devops-test" && exit 0)
	@echo ""
	@echo "📁 Mounting current directory to VM..."
	@multipass mount . devops-test:/workspace || true
	@echo ""
	@echo "✅ VM is ready!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. multipass shell devops-test"
	@echo "  2. cd /workspace"
	@echo "  3. make setup"
	@echo ""
	@echo "To clean up: make clean-multipass"

test-docker: ## Test using Docker container
	@echo "🐳 Building Docker test image..."
	@docker build -f Dockerfile.test -t devops-test:latest .
	@echo ""
	@echo "🚀 Starting test container..."
	@echo "Files are mounted from current directory"
	@echo ""
	@docker run -it --rm \
		-v $(PWD):/workspace \
		-w /workspace \
		devops-test:latest \
		bash -c "echo '✅ Container ready! Run: make setup' && bash"

test-vagrant: ## Test using Vagrant (requires VirtualBox)
	@echo "📦 Starting Vagrant VM..."
	@vagrant up
	@echo ""
	@echo "✅ VM is ready!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. vagrant ssh"
	@echo "  2. cd /vagrant"
	@echo "  3. make setup"
	@echo ""
	@echo "To clean up: vagrant destroy"

clean-multipass: ## Clean up Multipass VM
	@echo "🧹 Cleaning up Multipass VM..."
	@multipass stop devops-test 2>/dev/null || true
	@multipass delete devops-test 2>/dev/null || true
	@multipass purge 2>/dev/null || true
	@echo "✅ Cleanup complete"

clean-docker: ## Clean up Docker test image
	@echo "🧹 Cleaning up Docker test image..."
	@docker rmi devops-test:latest 2>/dev/null || true
	@echo "✅ Cleanup complete"

clean-vagrant: ## Clean up Vagrant VM
	@echo "🧹 Cleaning up Vagrant VM..."
	@vagrant destroy -f
	@echo "✅ Cleanup complete"

