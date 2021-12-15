#!/usr/bin/env bash

# Link all files excluding .config
for file in $(find . -type f | grep -vE '\.config|.exclude*|\.git/|\.gitignore|\.sh$|.*.md$|\.DS_Store/*'); do
  ln -sfv "$PWD/$file" ~/"$file"
done

# Link .config
ln -sfvn "$PWD/.config" ~/.config

ln -sfvn "$PWD/bin" ~/bin

