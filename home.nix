{ config, pkgs, lib, ... }:
{
  imports = [
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./tmux.nix
    ./shell.nix
  ];

#   terraform-config-inspect = buildGoModule rec {
#     name = "terraform-config-inspect";
#     version = "latest";
#
#     src = fetchFromGitHub {
#       owner = "hashicorp";
#       repo = "terraform-config-inspect";
#       rev = "a34142ec2a72dd916592afd3247dd354f1cc7e5c";
#       hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
#     };
#
#     vendorHash = null;
#
#     # doCheck = false;
#     # goPackagePath = "github.com/hashicorp/terraform-config-inspect";
#   };


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
      pkgs.pkgs-stable.azure-cli
      # qmk # not working on aarch64-darwin
      ngrok
      pkgs.pkgs-stable.shopify-cli
      miniserve
      pre-commit
      wireguard-tools
      # act # https://github.com/nektos/act
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

      (buildGoModule rec {
        name = "terraform-config-inspect";
        version = "latest";

        src = fetchFromGitHub {
          owner = "hashicorp";
          repo = "terraform-config-inspect";
          rev = "a34142ec2a72dd916592afd3247dd354f1cc7e5c";
          hash = "sha256-+NsVQ3K7fiQjI/41kPV3iAzFO3Z3Z4oeUA5gJgR+EyU=";
        };

        vendorHash = "sha256-JO02/PrlyFpQnNAb0ZZ8sfGiMmGjtbhwmAasWkHPg1A=";
      })
      (buildGoModule rec {
        pname = "updo";
        version = "0.1.1";

        src = fetchFromGitHub {
          owner = "Owloops";
          repo = "updo";
          rev = "v${version}";
          hash = "sha256-sZfCtN7f80Qla6qzrl2iQ7V+lJeaDYA0DAAbiVXuxRQ=";
        };

        vendorHash = "sha256-lkNvVAtq4CxQQ8Buw+waWbId0XdLRnN/w6pE6C8fEgA=";
      })
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
    htop.enable = false;
    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.bottom.enable
    bottom.enable = true;

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
    # TODO: enable when unbroken
    broot = {
      enable = true;
    };

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
