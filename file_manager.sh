#!/bin/bash
# Simple Bash File Manager

current_dir=$(pwd)

while true; do
    clear
    echo "========================="
    echo " Bash File Manager"
    echo " Current Directory: $current_dir"
    echo "========================="
    echo
    echo "Files:"
    
    # List files with numbering
    files=("$current_dir"/*)
    for i in "${!files[@]}"; do
        echo "$((i+1)). $(basename "${files[$i]}")"
    done

    echo
    echo "Options:"
    echo "n - Navigate to directory"
    echo "o - Open file"
    echo "c - Copy file"
    echo "m - Move file"
    echo "d - Delete file"
    echo "u - Go up one directory"
    echo "q - Quit"
    echo
    read -p "Choose an option: " option

    case $option in
        n)
            read -p "Enter directory number to navigate: " dir_num
            if [ -d "${files[$((dir_num-1))]}" ]; then
                current_dir="${files[$((dir_num-1))]}"
            else
                echo "Not a directory!"
                sleep 1
            fi
            ;;
        o)
            read -p "Enter file number to open: " file_num
            if [ -f "${files[$((file_num-1))]}" ]; then
                xdg-open "${files[$((file_num-1))]}" 2>/dev/null &
            else
                echo "Not a file!"
                sleep 1
            fi
            ;;
        c)
            read -p "Enter file number to copy: " file_num
            read -p "Enter destination path: " dest
            cp -r "${files[$((file_num-1))]}" "$dest"
            ;;
        m)
            read -p "Enter file number to move: " file_num
            read -p "Enter destination path: " dest
            mv "${files[$((file_num-1))]}" "$dest"
            ;;
        d)
            read -p "Enter file number to delete: " file_num
            rm -r "${files[$((file_num-1))]}"
            ;;
        u)
            current_dir=$(dirname "$current_dir")
            ;;
        q)
            echo "Exiting File Manager..."
            exit 0
            ;;
        *)
            echo "Invalid option!"
            sleep 1
            ;;
    esac
done
