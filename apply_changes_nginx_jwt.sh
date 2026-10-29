#!/bin/sh

PORT_DIR=/usr/ports/www/nginx
PATCHES_DIR=$(pwd)/files/

if [ ! -d" ${PORT_DIR}" ];then
    echo "FreeBSD  ports not found"
    exit 1  # Exit the script with an error status
fi

cd ${PORT_DIR}

# Loop through all files with the .patch extension in the pathes/ directory
for PATCH_FILE in ${PATCHES_DIR}patch-*; do
    [ -e "${PATCH_FILE}" ] || continue  # Check if the file exists

    echo "Applying patch: ${PATCH_FILE}"
    patch -u -p1 < "${PATCH_FILE}"

    # Check the exit status of the patch command
    if [ $? -eq 0 ]; then
        echo "Patch applied successfully."
    else
        echo "Error applying patch."
        exit 1  # Exit the script with an error status
    fi
done


