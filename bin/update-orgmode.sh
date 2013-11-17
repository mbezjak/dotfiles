#!/bin/bash
#

set -o errexit

function die  { exit 1; }
function fail { echo "$@"; die; }

cd ~/lib/org-mode
# http://stackoverflow.com/questions/6245570/get-current-branch-name
declare -r current=$(git rev-parse --abbrev-ref HEAD)

git checkout master
git pull origin master

declare -r latest=$(git tag | grep '^release' | sort --sort=version --reverse | head -n 1)
declare -r shortlast=$(echo $latest | awk -F_ '{print $2}')

[[ $current == $shortlast ]] && {
    git checkout $current
    fail "Already at latest tag: $current"
}

git log --oneline "release_$current...$latest"
git checkout -b $shortlast $latest

make clean autoloads

exit 0
