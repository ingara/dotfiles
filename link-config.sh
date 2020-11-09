#!/usr/bin/env bash

for file in $(find . -type f | grep -vE '\.exclude*|\.git/*|\.gitignore|\.sh$|.*.md$|\.DS_Store/*'); do
  ln -sfv "$PWD/$file" ~/"$file"
done

