{ config, pkgs, ... }:
{
  imports = [
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./tmux.nix
    ./shell.nix
  ];

  home = {
    stateVersion = "22.11";
    file = {
      hammerspoon = {
        source = ./configs/hammerspoon;
        target = ".hammerspoon";
        recursive = true;
      };
      ideavimrc = {
        target = ".config/ideavim/ideavimrc";
        source = ./configs/.ideavimrc;
      };
      yabai = {
        executable = true;
        target = ".config/yabai/yabairc";
        text = ''
          yabai -m rule --add app="^System Preferences$" manage=off
          yabai -m rule --add app="^Alacritty$" manage=off
          yabai -m rule --add app="^1Password$" manage=off
        '';
      };
      ".config/skhd/skhdrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dev/dotfiles/configs/skhdrc";
      ".config/lazygit/config.yml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dev/dotfiles/configs/lazygit.yml";
      ".config/alacritty.yml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dev/dotfiles/configs/alacritty.yml";
    };

    packages = with pkgs; [
      colima
      docker
      fd
      htop
      nixpkgs-fmt
      nodejs_18
      ripgrep
      # magic-wormhole
      azure-cli
      # qmk # not working on aarch64-darwin
      ngrok
      shopify-cli
      miniserve
      pre-commit
      wireguard-tools
      act # https://github.com/nektos/act
      git-absorb
      k6

      ##TF
      # terraform
      # tfenv # installed with brew
      tflint
      terragrunt


      # k8s stuff
      kubectl
      kubecolor
      kubectx
      yq-go

      # Better userland for macOS
      coreutils
      findutils
      gnugrep
      gnused

      # npm stuff
      nodePackages.vercel
      nodePackages_latest.pnpm

      # yabai
      # skhd
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      XDG_CONFIG_HOME = "$HOME/.config";
    };
  };

  editorconfig = {
    enable = true;
    settings = {
      # Unix-style newlines with a newline ending every file
      "*" =
        {
          end_of_line = "lf";
          charset = "utf-8";
          indent_style = "space";
          indent_size = 2;
          trim_trailing_whitespace = true;
          insert_final_newline = true;
        };

      "*.elm" = {
        indent_size = 4;
      };
      "*.kts?" = {
        indent_size = 4;
      };
      "*.swift" = {
        indent_size = 4;
      };
    };
  };

  programs = {
    # Let home-manager manage itself
    home-manager.enable = true;

    bat.enable = true;
    jq.enable = true;

    gpg = {
      enable = true;
    };

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.lazygit.enable
    lazygit = {
      enable = true;
    };

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.eza.enable
    eza = {
      enable = true;
      enableAliases = false; # defining my own aliases in zsh.nix
    };

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
    htop.enable = true;

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.alacritty.enable
    alacritty.enable = true;

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.k9s.enable
    k9s.enable = true;

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.tealdeer.enable
    tealdeer.enable = true;

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.broot.enable
    broot.enable = true;

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.rbenv.enable
    rbenv = {
      enable = true;
      plugins = [
        {
          name = "ruby-build";
          src = pkgs.fetchFromGitHub {
            owner = "rbenv";
            repo = "ruby-build";
            rev = "v20221225";
            hash = "sha256-Kuq0Z1kh2mvq7rHEgwVG9XwzR5ZUtU/h8SQ7W4/mBU0=";
          };
        }
      ];
    };
  };
}
