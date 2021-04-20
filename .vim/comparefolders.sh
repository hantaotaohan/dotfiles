#!/bin/bash

# ---------------------------------------------------------------
#
# Compare Folders
#
# Bash Script to compare files in two different folders of a certain extension.
# This is useful for finding roms that are missing snaps.
# e.g if a rom is named something like, "Zoboomafoo - Leapin' Lemurs [SLUS_014.01].pbp",
# and your media (boxart, snaps, etc..) is named something like "Zoboomafoo - Leapin' Lemurs (USA).mp4",
#
# With the help of:
# http://stackoverflow.com/questions/26935515/in-linux-how-to-compare-two-directories-by-filename-only-and-get-list-of-result
# How to read bash script flags: http://stackoverflow.com/questions/14447406/bash-shell-script-check-for-a-flag-and-grab-its-value
# ---------------------------------------------------------------
function CompareFolders() {

if [ "$#" -ne 4 ]; then

        # Not Enough Params, Show Usage
        echo "Rom/Snap Folder Compare"
        echo "USAGE: [script.sh] [folder 1] [folder 2] [file exenstions of folder 1] [file extensions of folder two]"

    echo "NOTE: Extensions should have no '.', and folders should have no trailing slash"
    exit 0
fi


SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
folder1=$1
folder2=$2
ext1=$3
ext2=$4


for fullfile in ${folder1}/*.$ext1
do
        #echo "$fullfile fullfile"
        filename=$(basename "$fullfile")
        #echo "$filename file"
        extension="${filename##*.}"
        #echo "$extension ext"
        cleanfilename="${filename%.*}"
        #echo "$cleanfilename base"
        if ! [ -a "${folder2}/$cleanfilename.$ext2" ]
        then
                echo $fullfile
        fi
done
IFS=$SAVEIFS
}

#vimwiki is docs folder (markdown)
dir1=$HOME/vimwiki/src
#vimwiki is docs folder (html)
dir2=$HOME/vimwiki/docs

#CompareFolders 文件夹1 文件夹2 文件夹1的后缀 文件夹2的后缀
if [ -d $HOME/vimwiki ]; then
    CompareFolders ${dir2} ${dir1} html md | xargs -r -p rm
fi

#如果需要删除利用管道符号
#./del.sh ~/test2 ~/test1 html md | xargs rm
# ./comparefolders.sh ~/vimwiki/docs ~/vimwiki/src html md | xargs rm
