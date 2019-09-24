#!/usr/bin/env bash

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2 && exit 11
#)Created by argbash-init v2.8.1
# ARG_OPTIONAL_SINGLE([package-manager], [p], [Select the package manager for install Ansible: apt or pip], [apt])
# ARG_OPTIONAL_BOOLEAN([local], [l], [Local installation of Ansible, only for pip package manager], [off])
# ARG_HELP([Simple installation script for Ansible and Ansible Playbook to setup you own workstation])
# ARGBASH_GO

# [ <-- needed because of Argbash

APL_INSTALL_DIR=${APL_INSTALL_DIR:-~/.local/lib/apl/workstation-config}
APL_REPOSITORY=${APL_REPOSITORY:-https://github.com/shimarulin/workstation-config.git}
APL_BRANCH=${APL_BRANCH:-master}

setup_color() {
  if [[ -t 1 ]]; then
    RED=$(printf '\033[31m') # match square bracket: ]
    GREEN=$(printf '\033[32m') # match square bracket: ]
    YELLOW=$(printf '\033[33m') # match square bracket: ]
    BLUE=$(printf '\033[34m') # match square bracket: ]
    BOLD=$(printf '\033[1m') # match square bracket: ]
    RESET=$(printf '\033[m') # match square bracket: ]
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    RESET=""
  fi
}

install_deps () {
  if [[ $(command -v ansible) == '' ]]; then
    echo "${BLUE}Install dependencies...${RESET}"

    sudo apt update
    sudo apt upgrade --yes

    if [[ ${_arg_package_manager} = pip ]]; then
      sudo apt install --yes \
        git \
        python3-pip
    elif [[ ${_arg_package_manager} = apt ]]; then
      sudo apt-add-repository --yes --update ppa:ansible/ansible
      sudo apt install --yes \
        git
    else
      _PRINT_HELP=yes die "FATAL ERROR: Got an unexpected value of the 'package-manager' argument: '$_arg_package_manager'" 1
    fi

    if [[ ${_arg_package_manager} = pip && ${_arg_local} = on ]]; then
      pip3 install --user ansible
    elif [[ ${_arg_package_manager} = pip && ${_arg_local} = off ]]; then
      sudo pip3 install ansible
    else
      sudo apt install --yes ansible
    fi

  fi
}

install_apl () {
  printf "$YELLOW"
  git clone --depth=1 --branch "$APL_BRANCH" "$APL_REPOSITORY" "$APL_INSTALL_DIR" || {
    error "git clone of ansible playbook repo failed"
    exit 1
  }
  printf "$RESET"
}

main() {
  setup_color

  install_deps
  install_apl

  printf "$GREEN"
  printf "$BOLD"
  cat <<EOF

        ___    ____  __
       /   |  / __ \/ /
      / /| | / /_/ / /
     / ___ |/ ____/ /___
    /_/  |_/_/   /_____/

    ...is now installed!

    You Ansible playbook installed to ${BLUE}$APL_INSTALL_DIR${GREEN}

EOF
  printf "$RESET"
}

main "$@"
# ] <-- needed because of Argbash
