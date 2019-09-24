#!/usr/bin/env bash

# Created by argbash-init v2.8.1
# ARG_OPTIONAL_SINGLE([package-manager],[p],[Select the package manager for install Ansible: apt or pip],[apt])
# ARG_OPTIONAL_BOOLEAN([local],[l],[Local installation of Ansible, only for pip package manager],[off])
# ARG_HELP([Simple installation script for Ansible and Ansible Playbook to setup you own workstation])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.8.1 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
	local _ret=$2
	test -n "$_ret" || _ret=1
	test "$_PRINT_HELP" = yes && print_help >&2
	echo "$1" >&2
	exit ${_ret}
}


begins_with_short_option()
{
	local first_option all_short_options='plh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_package_manager="apt"
_arg_local="off"


print_help()
{
	printf '%s\n' "Simple installation script for Ansible and Ansible Playbook to setup you own workstation"
	printf 'Usage: %s [-p|--package-manager <arg>] [-l|--(no-)local] [-h|--help]\n' "$0"
	printf '\t%s\n' "-p, --package-manager: Select the package manager for install Ansible: apt or pip (default: 'apt')"
	printf '\t%s\n' "-l, --local, --no-local: Local installation of Ansible, only for pip package manager (off by default)"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-p|--package-manager)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_package_manager="$2"
				shift
				;;
			--package-manager=*)
				_arg_package_manager="${_key##--package-manager=}"
				;;
			-p*)
				_arg_package_manager="${_key##-p}"
				;;
			-l|--no-local|--local)
				_arg_local="on"
				test "${1:0:5}" = "--no-" && _arg_local="off"
				;;
			-l*)
				_arg_local="on"
				_next="${_key##-l}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-l" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			*)
				_PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
				;;
		esac
		shift
	done
}

parse_commandline "$@"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
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
