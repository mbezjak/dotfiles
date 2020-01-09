#!/bin/bash
#

set -o errexit

export BORG_REPO='ssh://u167296@u167296.your-storagebox.de:23/./laptop'

info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"
borg create                         \
     --verbose                      \
     --filter AME                   \
     --list                         \
     --stats                        \
     ::'{hostname}-{now}'           \
                                    \
     ~/Documents                    \
     ~/Sync                         \
     ~/workspace                    \
     ~/.gramps

backup_exit=$?

info "Pruning repository"
borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-daily    3               \
    --keep-weekly   4               \
    --keep-monthly  6               \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 1 ];
then
    info "Backup and/or Prune finished with a warning"
fi

if [ ${global_exit} -gt 1 ];
then
    info "Backup and/or Prune finished with an error"
fi

exit ${global_exit}
