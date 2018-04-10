#!/bin/bash
ignore=("update.sh" "urls.sh" "urls.txt" "web-indent")
for dir in `ls`
do 
    if [[ ${ignore[*]} =~ $(echo "\<$dir\>" ) ]]; then
        echo "ignoring $dir"
    else
        echo git -C $dir config --get remote.origin.url
        git -C $dir config --get remote.origin.url
        echo '' > urls.txt
        git -C $dir config --get remote.origin.url >> urls.txt
    fi
    echo
done

