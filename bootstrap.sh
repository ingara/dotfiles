#!/usr/bin/env bash

# Based on https://github.com/mathiasbynens/dotfiles/blob/master/bootstrap.sh
# and https://github.com/Overbryd/dotfiles/blob/master/bootstrap.sh

cd "$(dirname "${BASH_SOURCE}")";

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "setup-macos.sh" \
		--exclude "brew.sh" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;
	source ~/.bash_profile;


  # generate a new, strong rsa ssh key
  ssh-keygen -t rsa -b 4096

  # wait for the user to add it to github
  pbcopy < ~/.ssh/id_rsa.pub
  echo "Now login to https://github.com/settings/keys and add the key that has already been copied to your clipboard."
  read -p "Press any key to continue. Ctrl-C to abort."

  # install Xcode Command Line Tools
  # https://github.com/timsutton/osx-vm-templates/blob/ce8df8a7468faa7c5312444ece1b977c1b2f77a4/scripts/xcode-cli-tools.sh
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    tr -d '\n')
  softwareupdate -i "$PROD" -v

  # Install brew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"ash -c "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
  brew analytics off

  # Install Oh-My-Zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  ./brew.sh
  ./setup-macos.sh
  git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

  brew services start yabai
  brew services start skhd
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
