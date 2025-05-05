#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 <source1> <dest1> [<source2> <dest2> ...]"
    exit 1
fi

while [ $# -gt 1 ]; do
    src_dir="$1"
    dest_symlink="$2"
    shift 2

    if [ ! -e "$src_dir" ]; then
        echo "Source '$src_dir' does not exist. Skipping..."
    elif [ "$src_dir" == "$dest_symlink" ]; then
        echo "Source and destination are the same: '$src_dir'. Skipping..."
    else
        echo "Creating symlink: $src_dir -> $dest_symlink"
        ln -sfn "$src_dir" "$dest_symlink"
    fi
done

echo "Symlinks creation complete."

