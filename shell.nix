{ pkgs, config, ... }:

{
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.fish.enable
  programs.fish = {
    enable = true;

    shellAliases = {
      cat = "bat";
      g = "git";
      dr = "darwin-rebuild";
      tls = "tmux-lazy-session";
      tf = "terraform";
      lg = "lazygit";
      kubectl = "kubecolor";
      br = "broot";
      vim = "nvim";

      # Eza stuff
      ls = "eza";
      l = "eza -l --all --group-directories-first --git";
      ll = "eza -l --all --all --group-directories-first --git";
      lt = "eza -T --git-ignore --level=2 --group-directories-first";
      llt = "eza -lT --git-ignore --level=2 --group-directories-first";
      lT = "eza -T --git-ignore --level=4 --group-directories-first";
    };

    shellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.enable
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cat = "bat";
      g = "git";
      dr = "darwin-rebuild";
      tls = "tmux-lazy-session";
      tf = "terraform";
      lg = "lazygit";
      kubectl = "kubecolor";
      br = "broot";

      # Eza stuff
      ls = "eza";
      l = "eza -l --all --group-directories-first --git";
      ll = "eza -l --all --all --group-directories-first --git";
      lt = "eza -T --git-ignore --level=2 --group-directories-first";
      llt = "eza -lT --git-ignore --level=2 --group-directories-first";
      lT = "eza -T --git-ignore --level=4 --group-directories-first";
    };
    oh-my-zsh = {
      enable = true;
      theme = "bira";
      plugins = [
        "git"
        "sudo"
        "colorize"
        "kubectl"
      ];
    };

    initExtra = ''
      nixify() {
        if [ ! -e ./.envrc ]; then
          echo "use nix" > .envrc
          direnv allow
        fi
        if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
          cat > default.nix <<'EOF'
      with import <nixpkgs> {};
      mkShell {
        nativeBuildInputs = [
          bashInteractive
        ];
      }
      EOF
          ${EDITOR:-vim} default.nix
        fi
      }
      flakify() {
        if [ ! -e flake.nix ]; then
          nix flake new -t github:nix-community/nix-direnv .
        elif [ ! -e .envrc ]; then
          echo "use flake" > .envrc
          direnv allow
        fi
        ${EDITOR:-vim} flake.nix
      }
      eval "$(/opt/homebrew/bin/brew shellenv)"
      export XDG_CONFIG_HOME="$HOME/.config"
    '';
  };

  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.starship.enable
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      directory = {
        truncation_length = 5;
        truncation_symbol = "…/";
        truncate_to_repo = false;
        substitutions = {
          "Documents" = " ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      shell =
        {
          disabled = false;
          fish_indicator = "🐟";
          zsh_indicator = "𝓏";
        };

      aws = {
        format = "\\[[$symbol($profile)(($region))([$duration])]($style)\\]";
      };

      c = { format = "\\[[$symbol($version(-$name))]($style)\\]"; };

      cmake = { format = "\\[[$symbol($version)]($style)\\]"; };

      cmd_duration = { format = "\\[[⏱ $duration]($style)\\]"; };

      cobol = { format = "\\[[$symbol($version)]($style)\\]"; };

      conda = { format = "\\[[$symbol$environment]($style)\\]"; };

      crystal = { format = "\\[[$symbol($version)]($style)\\]"; };

      daml = { format = "\\[[$symbol($version)]($style)\\]"; };

      dart = { format = "\\[[$symbol($version)]($style)\\]"; };

      deno = { format = "\\[[$symbol($version)]($style)\\]"; };

      docker_context = { format = "\\[[$symbol$context]($style)\\]"; };

      dotnet = { format = "\\[[$symbol($version)(🎯 $tfm)]($style)\\]"; };

      elixir = { format = "\\[[$symbol($version (OTP $otp_version))]($style)\\]"; };

      elm = { format = "\\[[$symbol($version)]($style)\\]"; };

      erlang = { format = "\\[[$symbol($version)]($style)\\]"; };

      gcloud = { format = "\\[[$symbol$account(@$domain)(($region))]($style)\\]"; };

      git_branch = { format = "\\[[$symbol$branch]($style)\\]"; };

      git_status = { format = "([\\[$all_status$ahead_behind\\]]($style))"; };

      golang = { format = "\\[[$symbol($version)]($style)\\]"; };

      haskell = { format = "\\[[$symbol($version)]($style)\\]"; };

      helm = { format = "\\[[$symbol($version)]($style)\\]"; };

      hg_branch = { format = "\\[[$symbol$branch]($style)\\]"; };

      java = { format = "\\[[$symbol($version)]($style)\\]"; };

      julia = { format = "\\[[$symbol($version)]($style)\\]"; };

      kotlin = { format = "\\[[$symbol($version)]($style)\\]"; };

      kubernetes = { format = "\\[[$symbol$context( ($namespace))]($style)\\]"; };

      lua = { format = "\\[[$symbol($version)]($style)\\]"; };

      memory_usage = { format = "\\[$symbol[$ram( | $swap)]($style)\\]"; };

      nim = { format = "\\[[$symbol($version)]($style)\\]"; };

      nix_shell = { format = "\\[[$symbol$state( ($name))]($style)\\]"; };

      nodejs = { format = "\\[[$symbol($version)]($style)\\]"; };

      ocaml = { format = "\\[[$symbol($version)(($switch_indicator$switch_name))]($style)\\]"; };

      openstack = { format = "\\[[$symbol$cloud(($project))]($style)\\]"; };

      package = { format = "\\[[$symbol$version]($style)\\]"; };

      perl = { format = "\\[[$symbol($version)]($style)\\]"; };

      php = { format = "\\[[$symbol($version)]($style)\\]"; };

      pulumi = { format = "\\[[$symbol$stack]($style)\\]"; };

      purescript = { format = "\\[[$symbol($version)]($style)\\]"; };

      python = { format = "\\[[$\{symbol}$\{pyenv_prefix}($\{version})(\($virtualenv\))]($style)\\]"; };

      raku = { format = "\\[[$symbol($version-$vm_version)]($style)\\]"; };

      red = { format = "\\[[$symbol($version)]($style)\\]"; };

      ruby = { format = "\\[[$symbol($version)]($style)\\]"; };

      rust = { format = "\\[[$symbol($version)]($style)\\]"; };

      scala = { format = "\\[[$symbol($version)]($style)\\]"; };

      spack = { format = "\\[[$symbol$environment]($style)\\]"; };

      sudo = { format = "\\[[as $symbol]\\]"; };

      swift = { format = "\\[[$symbol($version)]($style)\\]"; };

      terraform = { format = "\\[[$symbol$workspace]($style)\\]"; };

      time = { format = "\\[[$time]($style)\\]"; };

      username = { format = "\\[[$user]($style)\\]"; };

      vagrant = { format = "\\[[$symbol($version)]($style)\\]"; };

      vlang = { format = "\\[[$symbol($version)]($style)\\]"; };

      zig = { format = "\\[[$symbol($version)]($style)\\]"; };
    };
  };
}
