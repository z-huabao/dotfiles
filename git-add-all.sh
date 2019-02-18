#!/usr/bin/env bash

files=$(find ./ | grep .git -v)
#echo ${files//.\// }

for f in ${files}
do
    if [[ -d $f ]]; then
        echo "pass dir: $f"
    else
        if [ ${f:(-4)} == ".pyc" ]; then
            echo "pass file: $f"
        else
            echo "add file: $f"
            git add -f $f
        fi
    fi
done

#git commit -m $1
#git push -u origin master
#git push

