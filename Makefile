.PHONY: help setup lint install-pre-commit run-pre-commit clean check-ansible check-ubuntu

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
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK)

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

