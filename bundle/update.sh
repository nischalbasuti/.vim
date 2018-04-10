#!/bin/bash
ignore=("update.sh" "urls.sh" "urls.txt" "YouCompleteMe" "web-indent")
for dir in `ls`
do 
    if [[ ${ignore[*]} =~ $(echo "\<$dir\>" ) ]]; then
        echo "ignoring $dir"
    else
        echo git -C $dir pull
        git -C $dir pull
    fi
    echo
done

