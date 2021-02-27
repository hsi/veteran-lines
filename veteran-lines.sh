#!/usr/bin/env bash

set -e

for file in $(git ls-tree -r master --name-only); do
    [ -f "$file" ] && {
        escaped_file=$(echo "$file" | sed -e 's/[\/&]/\\&/g')

        git blame --date=format:'%Y-%m-%d' $file |
        sed 's/\([[:alnum:]]\+\)\s\+\([[:alnum:][:punct:]]\+\)\s\+.\+\([[:digit:]]\{4\}-[[:digit:]]\{2\}-[[:digit:]]\{2\}\)\s\+\([[:digit:]]\+\).*/\3 '"$escaped_file"':\4/' |
        sort
    }
done | sort | head -n 10
