# APL

> Ansible playbook installer

```bash
bash -c "$(wget -O- https://raw.githubusercontent.com/shimarulin/apl/master/install.sh)"
```

Usages:

```
Simple installation script for Ansible and Ansible Playbook to setup you own workstation
Usage: ./install.sh [-p|--package-manager <arg>] [-l|--(no-)local] [-h|--help]
        -p, --package-manager: Select the package manager for install Ansible: 'apt' or 'pip' (default: 'apt')
        -l, --local, --no-local: Local installation of Ansible, only for pip package manager (off by default)
        -h, --help: Prints help
```

You can setup installer via environment variables:

- `APL_INSTALL_DIR` - place to install Ansible playbook (default: `~/.local/lib/apl/workstation-config`)
- `APL_REPOSITORY` - full remote URL of the git repo to install (default: `https://github.com/shimarulin/workstation-config.git`)
- `APL_BRANCH` - branch to check out immediately after install (default: `master`)

For example:

```bash
APL_INSTALL_DIR="$HOME/.opt/apl" bash -c "$(wget -O- https://raw.githubusercontent.com/shimarulin/apl/master/install.sh)"
```

## Development

To generate command line arguments parser you need to have installed [argbash](https://argbash.io/). Quick steps to get it:

- Get latest source from https://github.com/matejak/argbash/releases
- open `resources` directory in terminal
- run `make install PREFIX=$HOME/.local`

Generate script:

```bash
argbash -o install.sh install.m4
```
