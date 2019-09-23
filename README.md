# APL

> Ansible playbook installer

This branch provides support of Python 3.

```bash
bash -c "$(wget -O- https://raw.githubusercontent.com/shimarulin/apl/python3/install.sh)"
```

You can setup installer via environment variables:

- `APL_INSTALL_DIR` - place to install Ansible playbook (default: `~/.local/lib/apl/workstation-config`)
- `APL_REPOSITORY` - full remote URL of the git repo to install (default: `https://github.com/shimarulin/workstation-config.git`)
- `APL_BRANCH` - branch to check out immediately after install (default: `master`)

For example:

```bash
APL_INSTALL_DIR="$HOME/.opt/apl" bash -c "$(wget -O- https://raw.githubusercontent.com/shimarulin/apl/python3/install.sh)"
```
