#!/usr/bin/env bash
# alias hex2binf="python3 ~/.scripts/hex2bin.py"

echo "Calculating checksum for $1..."

sig="$(sha256sum $1)"
first=true
IFS=' '
read -ra sigArr <<< $sig
for i in "${sigArr[@]}"; do
    if $first; then
        first=false
        echo "Checksum: $i"
        python3 ~/.scripts/hex2bin.py "$1.bin" $i
    fi
done

