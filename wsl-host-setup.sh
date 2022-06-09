#!/bin/bash

set -euo pipefail

source /etc/lsb-release

[ "$DISTRIB_ID" = "Ubuntu" ] && [ "$DISTRIB_RELEASE" = "22.04" ] || { echo "SETUP ONLY TESTED FOR UBUNTU 22.04" ; exit 1;}

asdf_install() {
    asdf_bash_install && \
    add_asdf_plugins && \
    asdf install
}

asdf_bash_install() {
    test -e "$HOME/.asdf" || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
    #shellcheck disable=SC2016
    grep -q '. $HOME/.bashrc_plethora' "$HOME/.bashrc" || \
        echo '. $HOME/.bashrc_plethora' >> "$HOME/.bashrc"
    #shellcheck disable=SC2016
    grep -q '. $HOME/.asdf/asdf.sh' "$HOME/.bashrc_plethora" || \
        echo '. $HOME/.asdf/asdf.sh' >> "$HOME/.bashrc_plethora"
    #shellcheck disable=SC2016
    grep -q '. $HOME/.asdf/completions/asdf.bash' "$HOME/.bashrc_plethora" || \
        echo '. $HOME/.asdf/completions/asdf.bash' >> "$HOME/.bashrc_plethora"
}

add_asdf_plugins() {
    asdf plugin add skaffold ||:
    asdf plugin add kubectl ||:
    asdf plugin add helm ||:
}

case "$SHELL" in
    /bin/bash) asdf_install ;;
    *) echo "INSTALL ASDF INSTALL MANUALLY" ; exit 1 ;;
esac
