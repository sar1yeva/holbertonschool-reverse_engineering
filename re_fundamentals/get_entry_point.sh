#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <elf_file>"
    exit 1
fi

file_name="$1"

# Check if file exists
if [ ! -f "$file_name" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Check if the file is a valid ELF file
if ! readelf -h "$file_name" >/dev/null 2>&1; then
    echo "Error: File is not a valid ELF file."
    exit 1
fi

# Load output function
source ./messages.sh

# Extract ELF header information
magic_number=$(readelf -h "$file_name" | awk '
/Magic:/ {
    for (i=2; i<=NF; i++) {
        printf "%s", $i
        if (i < NF)
            printf " "
    }
    printf "\n"
}')

class=$(readelf -h "$file_name" | awk -F: '
/Class:/ {
    gsub(/^[[:space:]]+/, "", $2)
    print $2
}')

byte_order=$(readelf -h "$file_name" | awk '
/Data:/ {
    if ($0 ~ /little endian/)
        print "little endian"
    else if ($0 ~ /big endian/)
        print "big endian"
}')

entry_point_address=$(readelf -h "$file_name" | awk -F: '
/Entry point address:/ {
    gsub(/^[[:space:]]+/, "", $2)
    print $2
}')

# Display the information
display_elf_header_info
