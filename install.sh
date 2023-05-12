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
mkdir --parents --mode=700 ~/Sync
mkdir --parents ~/workspace/{xattic,xforeign}
mkdir --parents ~/.lein
mkdir --parents ~/.clojure

install_link emacs.d .emacs.d
install_link lein/profiles.clj .lein/profiles.clj
install_link clojure/deps.edn .clojure/deps.edn
install_link config/systemd/user/dump-package-list.service .config/systemd/user/dump-package-list.service
install_link config/systemd/user/dump-package-list.timer .config/systemd/user/dump-package-list.timer
systemctl --user enable dump-package-list.service dump-package-list.timer

for f in $(find -mindepth 1 -maxdepth 1 -type f \
                -and -not -name '*.sh'   \
                -and -not -name '*.md'   \
                -and -not -name '*.work' \
                -and -not -name '.*'     \
                -printf '%f\n'); do
    install_link "$f" ".$f"
done

# remove dead symbolic links
find ~/bin -type l ! -exec test -r {} \; -exec rm -i {} \;

echo done
exit 0
