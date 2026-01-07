#!/bin/bash
# Test script for running the playbook in Docker

set -e

echo "🧪 Testing DevOps Machine Setup Playbook"
echo "========================================"
echo ""

# Test variables
GIT_USER="testuser"
GIT_EMAIL="test@example.com"

echo "📝 Test Configuration:"
echo "  Git User: $GIT_USER"
echo "  Git Email: $GIT_EMAIL"
echo ""

# Run the playbook with extra vars to bypass prompts
echo "🚀 Running playbook..."
ansible-playbook \
  -i ./inventories/hosts.ini \
  ./playbooks/tools_setup.yml \
  -e "git_user=$GIT_USER" \
  -e "git_email=$GIT_EMAIL" \
  -e "hostname_prefix=TEST" \
  -v

echo ""
echo "✅ Playbook execution completed!"

