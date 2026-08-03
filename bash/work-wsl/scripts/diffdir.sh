#!/usr/bin/env bash

# Argument checking
if [ -z "$1" ]; then
    echo "Missing first argument for diff directory"
    exit 1
fi

if [ -z $2 ]; then
    echo "Missing second argument for diff directory"
    exit 1
fi

if [ -z $3 ]; then
    echo "Missing third argument for file filter"
    exit 1
fi

# get first list of files

a="wigwambingbang"
tmp=${a%wigwam*}
echo $tmp

old="$(find "$1" -type f -name $3)"
echo "Contents of $1 with filter $3"
echo $old

