#!/usr/bin/env bash

printg() {
  printf "\e[32m$1\e[m\n"
}

SCRIPT_DIR="$( dirname -- "$( readlink -f -- "$0"; )"; )"
JOINED_FILE_NAME="RsDevPanelAll.swift"
JOINED_FILE_PATH="$SCRIPT_DIR/../$JOINED_FILE_NAME"
SOURCE_TARGET="$SCRIPT_DIR/../Sources/RSDevPanel/"

printg "- Start join all files RSDevPanel to one"
find $SOURCE_TARGET -name "*.swift" -type f -exec cat {} + > $JOINED_FILE_PATH
printg "- Done: $VAR_JOINED_FILE"
