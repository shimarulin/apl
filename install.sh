#!/usr/bin/env bash

APL_INSTALL_DIR=${APL_INSTALL_DIR:-~/.local/lib/apl/workstation-config}
APL_REPOSITORY=${APL_REPOSITORY:-https://github.com/shimarulin/workstation-config.git}
APL_BRANCH=${APL_BRANCH:-master}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
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
    sudo apt install --yes \
      software-properties-common \
      git \
      pip3
#    sudo apt-add-repository --yes --update ppa:ansible/ansible
#    sudo apt install --yes ansible
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
