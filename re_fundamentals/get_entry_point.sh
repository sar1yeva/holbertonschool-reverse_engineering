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

# Check if file is ELF
if ! readelf -h "$file_name" >/dev/null 2>&1; then
    echo "Error: File is not a valid ELF file."
    exit 1
fi

# Source messages.sh
source ./messages.sh

# Extract information
magic_number=$(readelf -h "$file_name" | grep "Magic:" | cut -d: -f2 | xargs)

class=$(readelf -h "$file_name" | grep "Class:" | awk -F: '{print $2}' | xargs)

byte_order=$(readelf -h "$file_name" | grep "Data:" | cut -d: -f2 | xargs)

entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | awk -F: '{print $2}' | xargs)

# Display information
display_elf_header_info
