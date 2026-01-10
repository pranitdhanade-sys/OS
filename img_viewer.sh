#!/bin/bash

# Check for feh
if ! command -v feh &>/dev/null; then
    echo "feh not found. Install it using: sudo apt install feh"
    exit 1
fi

# Ask for directory
read -p "Enter image directory path: " DIR

if [ ! -d "$DIR" ]; then
    echo "Directory not found!"
    exit 1
fi

# Collect images
mapfile -t IMAGES < <(find "$DIR" -maxdepth 1 -type f \( \
    -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.bmp" \))

COUNT=${#IMAGES[@]}

if [ "$COUNT" -eq 0 ]; then
    echo "No images found!"
    exit 1
fi

INDEX=0

while true; do
    clear
    echo "=============================="
    echo " Bash Image Viewer (v2)"
    echo " Image $((INDEX+1)) / $COUNT"
    echo "=============================="
    echo
    echo "n → next | p → previous | q → quit"
    echo

    feh --auto-zoom "${IMAGES[$INDEX]}" &
    FEH_PID=$!

    read -n1 -s KEY
    kill $FEH_PID 2>/dev/null

    case "$KEY" in
        n)
            ((INDEX++))
            [ "$INDEX" -ge "$COUNT" ] && INDEX=0
            ;;
        p)
            ((INDEX--))
            [ "$INDEX" -lt 0 ] && INDEX=$((COUNT-1))
            ;;
        q)
            clear
            exit 0
            ;;
    esac
done
