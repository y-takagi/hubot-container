#!/bin/bash
set -e

# rsync to tmp dir
rsync -C --filter=":- .gitignore" -rltuv --delete /app/ $tmp_dir
cd $tmp_dir

if [ "$1" = 'bin/hubot' ]; then
    exec "$@"
fi

"$@"

# rsync to /app
rsync -C --filter=":- .gitignore" -rltuv --delete $tmp_dir/ /app
