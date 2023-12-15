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

      # Eza stuff
      ls = "eza";
      l = "eza -l --all --group-directories-first --git";
      ll = "eza -l --all --all --group-directories-first --git";
      lt = "eza -T --git-ignore --level=2 --group-directories-first";
      llt = "eza -lT --git-ignore --level=2 --group-directories-first";
      lT = "eza -T --git-ignore --level=4 --group-directories-first";

      cdg = "cd $(git rev-parse --show-toplevel)";
    };
  };
}
