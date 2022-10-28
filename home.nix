{ config, pkgs, ... }:
{
  imports = [
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home = {
    stateVersion = "22.11";
    # username = user;
    file = {
      ideavimrc = {
        target = ".config/ideavim/ideavimrc";
        source = ./configs/.ideavimrc;
      };

      # ".config/lazygit/config.yml".source = ./configs/lazygit.yml;
    };

    packages = with pkgs; [
      colima
      docker
      fd
      htop
      nixpkgs-fmt
      nodejs-16_x
      ripgrep
      terraform
      tldr
      # lazygit
      # magic-wormhole
      azure-cli
      # qmk # not working on aarch64-darwin
      ngrok
      shopify-cli
      miniserve

      # Better userland for macOS
      coreutils
      findutils
      gnugrep
      gnused

      # npm stuff
      nodePackages.vercel
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
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

      # settings = (builtins.readFile ./configs/lazygit.yml);
      settings = {
        customCommands = [
          {
            key = "!";
            description = "Run git alias";
            command = "git {{index .PromptResponses 0}}";
            context = "global";
            subprocess = true;
            stream = true;
            prompts = [
              {
                type = "input";
                title = "Command (git alias)";
              }
            ];
          }
        ];
      };
    };

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.exa.enable
    exa = {
      enable = true;
      enableAliases = true;
    };

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
    htop.enable = true;

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      # config = {
      #   global = {
      #     skip_dotenv = true;
      #     load_dotenv = false;
      #   };
      # };
    };
  };
}
