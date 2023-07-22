#!/usr/bin/env bash

printg() {
  printf "\e[32m$1\e[m\n"
}

printg "- Make scripts executable"
chmod a+x makeJoinedFile.command
sudo xattr -cr makeJoinedFile.command
printg "- Done."
