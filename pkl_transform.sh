#!/bin/sh

# The path to the pkl config file that should be transformed.
PKL_CONFIG_FILE_PATH=$1
# The format to conver the pkl file to.
FORMAT=$2
# The destination to save the transformed file to.
OUTPUT=$3

test "$PKL_CONFIG_FILE_PATH" != "" || exit 1
test "$FORMAT" != "" || exit 1
test "$OUTPUT" != "" || exit 1

# Make sure the pkl binary exists.
which pkl || exit 1

pkl eval -f $FORMAT $PKL_CONFIG_FILE_PATH > $OUTPUT || exit 1
