#!/bin/bash
#

set -o errexit

install_link() {
    local s="$PWD/$1"
    local t="$HOME/$2"

    # link exists and points to source location
    [[ -L "$t" && "$(readlink -f "$t")" == "$s" ]] && return 0

    ln --symbolic --no-target-directory --interactive --verbose "$s" "$t"
}

cd $(dirname $(readlink -f "$0"))
git submodule init
git submodule update

mkdir --parents ~/bin
mkdir --parents ~/Documents
mkdir --parents ~/downloads
mkdir --parents ~/Dropbox
mkdir --parents ~/lib
mkdir --parents ~/workspace/{xattic,xincubation}
for f in bin/* lib/*; do
    install_link "$f" "$f"
done

install_link emacs.d .emacs.d
install_link lib/napalm/bin/napalm bin/napalm

for f in $(find -mindepth 1 -maxdepth 1 -type f \
                -and -not -name '*.sh'   \
                -and -not -name '*.md'   \
                -and -not -name '*.work' \
                -and -not -name '.*'     \
                -printf '%f\n'); do
    install_link "$f" ".$f"
done


if [[ "$1" == work ]]; then
    install_link hgrc.work .hgrc.local
fi

echo done
exit 0
