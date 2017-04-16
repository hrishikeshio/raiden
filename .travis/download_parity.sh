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

if [ ! -x $HOME/.bin/parity-${PARITY_VERSION} ]; then
    mkdir -p $HOME/.bin

    TEMP=$(mktemp -d)
    cd $TEMP
    # using curl becase wget doesn't work on mac
    curl $PARITY_URL -o parity

    install -m 755 parity $HOME/.bin/parity-${PARITY_VERSION}

    success "parity ${PARITY_VERSION} installed"
else
    info 'using cached parity'
fi


# always recreate the symlink since we dont know if it's pointing to a different
# version
[ -h $HOME/.bin/parity ] && unlink $HOME/.bin/parity
ln -s $HOME/.bin/parity-${PARITY_VERSION} $HOME/.bin/parity

