#!/bin/bash

# Check argument count
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

# Check if file is a valid ELF
if ! readelf -h "$file_name" >/dev/null 2>&1; then
    echo "Error: File is not a valid ELF file."
    exit 1
fi

# Load display function
source ./messages.sh

# Extract ELF header information
magic_number=$(readelf -h "$file_name" | awk -F: '/Magic:/ {gsub(/^[ \t]+/, "", $2); print $2}')

class=$(readelf -h "$file_name" | awk -F: '/Class:/ {gsub(/^[ \t]+/, "", $2); print $2}')

# Only extract "little endian" or "big endian"
byte_order=$(readelf -h "$file_name" | grep "Data:" | grep -oE '(little|big) endian')

entry_point_address=$(readelf -h "$file_name" | awk -F: '/Entry point address:/ {gsub(/^[ \t]+/, "", $2); print $2}')

# Display output
display_elf_header_info
