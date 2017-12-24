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
mkdir --parents ~/.lein
mkdir --parents ~/.sbt/0.13/plugins
mkdir --parents ~/.config/i3

install_link emacs.d .emacs.d
install_link lein/profiles.clj .lein/profiles.clj
install_link sbt/0.13/plugins/plugins.sbt .sbt/0.13/plugins/plugins.sbt
install_link i3/config .config/i3/config
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


if [[ "$1" == work ]]; then
    install_link hgrc.work .hgrc.local
elif [[ "$1" == home ]]; then
    install_link config/systemd/user/hetzner-backup.service .config/systemd/user/hetzner-backup.service
    install_link config/systemd/user/hetzner-backup.timer .config/systemd/user/hetzner-backup.timer
    systemctl --user enable hetzner-backup.service hetzner-backup.timer
fi

# remove dead symbolic links
find ~/bin -type l ! -exec test -r {} \; -exec rm -i {} \;

# remove old links that are no longer used
for f in $(find ~/bin -type l); do
    if [[ $(readlink -f "$f") = */dotfiles/bin/* ]]; then
        rm "$f"
    fi
done

# https://blog.g3rt.nl/upgrade-your-ssh-keys.html
if [[ ! -f ~/.ssh/id_ed25519.pub ]]; then
    ssh-keygen -o -a 100 -t ed25519 -C 'bezjak.miro@gmail.com'
fi

echo done
exit 0
