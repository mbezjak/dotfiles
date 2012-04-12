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

mkdir -p "$HOME/bin"
mkdir -p "$HOME/lib"
for f in bin/* lib/*; do
    install_link "$f" "$f"
done

install_link emacs.d .emacs.d
install_link lib/markdown/Markdown.pl bin/markdown
install_link lib/napalm/bin/napalm bin/napalm

for f in $(find -mindepth 1 -maxdepth 1 -type f \
                -and -not -name 'install.sh' \
                -and -not -name 'README.md' \
                -and -not -name '.*' \
                -printf '%f\n'); do
    install_link "$f" ".$f"
done

echo done
exit 0
