#!/usr/bin/env bash

set -e

fail() {
    if [[ $- == *i* ]]; then
       red=`tput setaf 1`
       reset=`tput sgr0`

       echo "${red}==> ${@}${reset}"
    fi
    exit 1
}

info() {
    if [[ $- == *i* ]]; then
        blue=`tput setaf 4`
        reset=`tput sgr0`

        echo "${blue}${@}${reset}"
    fi
}

success() {
    if [[ $- == *i* ]]; then
        green=`tput setaf 2`
        reset=`tput sgr0`
        echo "${green}${@}${reset}"
    fi

}

warn() {
    if [[ $- == *i* ]]; then
        yellow=`tput setaf 3`
        reset=`tput sgr0`

        echo "${yellow}${@}${reset}"
    fi
}

[ -z "${PARITY_URL}" ] && fail 'missing PARITY_URL'
[ -z "${PARITY_VERSION}" ] && fail 'missing PARITY_VERSION'

# if [ ! -x $HOME/.bin/geth-${GETH_VERSION} ]; then
#     mkdir -p $HOME/.bin

    TEMP=$(mktemp -d)
    cd $TEMP
    wget -O parity.deb $PARITY_URL
    sudo dpkg -i -y parity.deb

    success "parity ${PARITY_VERSION} installed"

