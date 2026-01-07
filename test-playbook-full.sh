#!/bin/bash
# Full test script for running the playbook in Docker
# This script will run the playbook and capture all output

set -e

echo "🧪 Full Playbook Test - DevOps Machine Setup"
echo "=============================================="
echo ""

# Test variables
GIT_USER="testuser"
GIT_EMAIL="test@example.com"

echo "📝 Test Configuration:"
echo "  Git User: $GIT_USER"
echo "  Git Email: $GIT_EMAIL"
echo "  Architecture: $(uname -m)"
echo ""

# Run the playbook with extra vars to bypass prompts
echo "🚀 Running full playbook test..."
echo "   This may take 15-30 minutes..."
echo ""

ansible-playbook \
  -i ./inventories/hosts.ini \
  ./playbooks/tools_setup.yml \
  -e "git_user=$GIT_USER" \
  -e "git_email=$GIT_EMAIL" \
  -e "hostname_prefix=TEST" \
  -v 2>&1 | tee /tmp/playbook-full-test.log

EXIT_CODE=${PIPESTATUS[0]}

echo ""
echo "=============================================="
if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ Playbook completed successfully!"
    echo ""
    echo "📊 Summary:"
    tail -20 /tmp/playbook-full-test.log | grep -E "(PLAY RECAP|ok=|changed=|failed=)" || echo "Check full log at /tmp/playbook-full-test.log"
else
    echo "❌ Playbook failed with exit code: $EXIT_CODE"
    echo ""
    echo "📋 Last 50 lines of output:"
    tail -50 /tmp/playbook-full-test.log
fi

exit $EXIT_CODE

