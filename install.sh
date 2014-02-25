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

mkdir --parents ~/bin
mkdir --parents ~/Documents
mkdir --parents ~/downloads
mkdir --parents --mode=700 ~/Dropbox
mkdir --parents ~/workspace/{xattic,xforeign}
for f in bin/*; do
    install_link "$f" "$f"
done

install_link emacs.d .emacs.d

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

# remove dead symbolic links
find ~/bin -type l ! -exec test -r {} \; -exec rm -i {} \;

echo done
exit 0
