## New machine

1. Generate ssh key and add it to github – https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
2. Install Rosetta – `sudo softwareupdate --install-rosetta --agree-to-license` (for using Intel apps on Silicon)
3. Install PragmataPro from https://fsd.it/my-account/
4. Clone this repo to `~/dev/dotfiles`
5. Follow below instructions

## Homebrew

Need to install homebrew manually, but all config of installed packages, casks and taps is done in `homebrew.nix`.

```sh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Keyboard layout (norwerty)

```sh
$ cd ~/Library/Keyboard\ Layouts
$ curl --remote-name https://raw.githubusercontent.com/tobiasvl/norwerty/master/mac/norwerty.keylayout
```

Then go to System Preferences -> Keyboard -> Input Sources -> + -> Other.

## Nix + nix-darwin + home manager

#### Bootstrapping

```shell
$ sh <(curl -L https://nixos.org/nix/install)
$ mkdir -p ~/dev
$ cd ~/dev
$ git clone git@github.com:ingara/dotfiles.git
$ cd dotfiles
$ nix build .#darwinConfigurations.ingar.system
# REBOOT if this reports that it cannot connect to Nix daemon
$ ./result/sw/bin/darwin-rebuild switch --flake .#ingar # still in ~/dev/dotfiles
```

### Link the darwin configuration from dotfiles

```shell
$ ln -s ~/dev/dotfiles/flake.nix ~/.nixpkgs/
```

### Install and configure stuff

```shell
$ darwin-rebuild switch
```

### Updating

```shell
$ nix flake update
```

### References:

| nix                  |                                                                   |
| -------------------- | ----------------------------------------------------------------- |
| home page            | https://nixos.org/download.html                                   |
| install tips for mac | https://gist.github.com/angerman/cbe02d814d81a8e4d4ced56b19046c19 |

| nix darwin |                                                  |
| ---------- | ------------------------------------------------ |
| github     | https://github.com/LnL7/nix-darwin               |
| manual     | https://daiderd.com/nix-darwin/manual/index.html |

| home manager |                                                                                       |
| ------------ | ------------------------------------------------------------------------------------- |
| installation | https://nix-community.github.io/home-manager/index.html#sec-install-nix-darwin-module |
| home page    | https://github.com/nix-community/home-manager                                         |
| options      | https://rycee.gitlab.io/home-manager/options.html                                     |

## Inspirations

- https://github.com/malob/nixpkgs/
- https://github.com/breuerfelix/dotfiles/
- https://github.com/lucperkins/nix-home-manager-config/
- https://alexpearce.me/2021/07/managing-dotfiles-with-nix/
- https://github.com/jwiegley/nix-config
- https://github.com/a-h/dotfiles
- https://github.com/utdemir/dotfiles
- https://gist.github.com/ksexton/89baeb4a8b518727242e4d933d49e315
- https://github.com/the-nix-way/nome
- https://github.com/fmoda3/nix-configs
