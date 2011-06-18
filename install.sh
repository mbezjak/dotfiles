#!/bin/bash
#

set -o errexit

cd $(dirname $(readlink -f "$0"))
git submodule init
git submodule update

install_link() {
    local s="$PWD/$1"
    local t="$HOME/$2"

    # link exists and points to source location
    [[ -L "$t" && "$(readlink -f "$t")" == "$s" ]] && return 0

    ln --symbolic --no-target-directory --interactive --verbose "$s" "$t"
}

install_link .emacs.d .emacs.d

mkdir -p "$HOME/bin"
mkdir -p "$HOME/local/lib"
for f in bin/* local/lib/*; do
    install_link "$f" "$f"
done

for f in $(find -mindepth 1 -maxdepth 1 -type f \
                -and -not -name '.gitmodules' \
                -and -not -name 'install.sh' \
                -and -not -name 'README.md' \
                -printf '%f\n'); do
    install_link "$f" "$f"
done

echo done
exit 0
