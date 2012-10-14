#!/bin/bash
#

set -o errexit

cd ~/Dropbox/lib/anki/german-to-croatian.media/

for f in *; do
  convert "$f" -resize 250x250 scaled
  mv scaled "$f"
done

exit 0
