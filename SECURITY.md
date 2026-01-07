# Security Policy

## Supported Versions

We actively support and provide security updates for:

| Version | Supported          |
| ------- | ------------------ |
| Latest  | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability, please **do not** open a public issue.

Instead, please email security concerns to: security@clouddrove.com

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

We will respond within 48 hours and work with you to address the issue.

## Security Best Practices

When using this playbook:

1. **Review before running**: Always review playbooks before executing on production systems
2. **Use in isolated environments first**: Test in a VM or isolated system
3. **Keep Ansible updated**: Use the latest version of Ansible
4. **Review downloaded packages**: The playbook downloads packages from official sources, but verify URLs
5. **Secure your inventory**: Don't commit sensitive inventory files
6. **Use vault for secrets**: Use Ansible Vault for any sensitive data

## Known Security Considerations

- The playbook requires sudo/root access to install system packages
- SSH keys are generated with configurable parameters (default: RSA 4096)
- All package repositories use official sources with GPG key verification
- Temporary files are cleaned up after installation

---

Thank you for helping keep this project secure! 🔒

