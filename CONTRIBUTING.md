# Contributing to DevOps Machine Setup

Thank you for your interest in contributing! 🎉

## How to Contribute

### Reporting Issues

If you find a bug or have a suggestion:
1. Check if the issue already exists
2. Create a new issue with:
   - Clear description
   - Steps to reproduce (if applicable)
   - Expected vs actual behavior
   - System information (OS, Ansible version)

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/your-feature-name`
3. **Make your changes**
4. **Test your changes**:
   ```bash
   make lint
   make syntax-check
   ```
5. **Commit your changes**: Use clear, descriptive commit messages
6. **Push to your fork**: `git push origin feature/your-feature-name`
7. **Create a Pull Request**

### Code Standards

- Follow Ansible best practices
- Run `make lint` before submitting
- Ensure all tests pass
- Update documentation if needed
- Keep commits focused and atomic

### Adding New Tools

When adding new tools to install:
1. Add variables to the appropriate role's `defaults/main.yml`
2. Add installation tasks to the role's `tasks/main.yml`
3. Update README.md with the new tool
4. Add appropriate tags for selective execution
5. Test the installation on a clean Ubuntu system

### Questions?

Feel free to open an issue for discussion or questions!

---

Thank you for contributing! 🙏

