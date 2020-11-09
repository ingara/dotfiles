#!/usr/bin/env bash

  # generate a new, strong rsa ssh key
  ssh-keygen -t rsa -b 4096

  # wait for the user to add it to github
  pbcopy < ~/.ssh/id_rsa.pub
  echo "Now login to https://github.com/settings/keys and add the key that has already been copied to your clipboard."
  read -p "Press any key to continue. Ctrl-C to abort."

