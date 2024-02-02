{ pkgs, ... }:

{
  home.packages = [
    pkgs.gh
    # pkgs.git
  ];
  programs.gh.enable = false;
  programs.git = {
    enable = true;
    userName = "Ingar Mathisen Almklov";
    userEmail = "ingara@gmail.com";
    delta = {
      enable = true;
      options = {
        line-numbers = true;
      };
    };
    ignores = [
      ".DS_Store"
      ".direnv"
      "shell.nix"
      ".envrc"
      "flake.lock"
      "flake.nix"
    ];

    signing = {
      signByDefault = true;
      key = "7A5F92617FB3E7A1";
    };

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      credential.helper = "osxkeychain";
      pull = {
        default = "current";
        rebase = true;
      };
      push.default = "current";
      rerere.enabled = true;
      "filter \"lfs\"" = {
        process = "git-lfs filter-process";
        required = true;
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
      };
    };

    aliases = {
      last = "log -1 --stat";
      c = "commit";
      ca = "commit --amend";
      cm = "commit -m";
      s = "status";
      br = "branch";
      d = "diff";
      dw = "diff -w";
      dc = "diff --cached";
      lg = "log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset' --abbrev-commit --date=relative --all";
      lgg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset' --abbrev-commit --date=relative --all";

      # Restore file from last commit where it existed
      restore-file = ''!git checkout $(git rev-list -n 1 HEAD -- "$1")^ -- "$1"'';

      # From https://github.com/not-an-aardvark/git-delete-squashed
      delete-squashed = ''!f() { DEFAULT=$(git default); local targetBranch=''${1-$DEFAULT} && git checkout -q $targetBranch && git branch --merged | grep -v "\*" | xargs --no-run-if-empty -n 1 git branch -d && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base $targetBranch $branch) && [[ $(git cherry $targetBranch $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done; }; f'';
      # From https://github.com/haacked/dotfiles/blob/main/git/gitconfig.aliases.symlink
      delete-cleanmerged = ''!f() { DEFAULT=$(git default); git branch --merged ''${1-$DEFAULT} | grep -v " ''${1-$DEFAULT}$" | xargs --no-run-if-empty git branch -d; }; f'';

      # Haacked aliases - https://github.com/haacked/dotfiles/blob/main/git/gitconfig.aliases.symlink
      abort = "rebase --abort";
      aliases = "!git config -l | grep ^alias\\. | cut -c 7-";
      amend = "commit -a --amend";
      # Deletes all branches merged into the specified branch (or the default branch if no branch is specified)
      bclean = "!f() { DEFAULT=$(git default); git delete-cleanmerged \${1-$DEFAULT} && git delete-squashed \${1-$DEFAULT}; }; f";
      # Switches to specified branch (or the dafult branch if no branch is specified), runs git up, then runs bclean.
      bdone = "!f() { DEFAULT=$(git default); git checkout \${1-$DEFAULT} && git up && git bclean \${1-$DEFAULT}; }; f";
      # Lists all branches including remote branches
      branches = "branch -a";
      browse = "!git open";
      # Lists the files with the most churn
      churn = "!git --no-pager log --name-only --oneline | grep -v ' ' | sort | uniq -c | sort -nr | head";
      cleanup = "clean -xdf -e *.DotSettings* -e s3_keys.ps1";
      # Stages every file then creates a commit with specified message
      co = "checkout";
      cob = "checkout -b";
      # Show list of files in a conflict state.
      conflicts = "!git diff --name-only --diff-filter=U";
      cp = "cherry-pick";
      default = "!git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'";
      delete = "branch -d";
      # Discard changes to a file
      discard = "checkout --";
      find = "!git ls-files | grep -i";
      graph = "log --graph -10 --branches --remotes --tags  --format=format:'%Cgreen%h %Creset• %<(75,trunc)%s (%cN, %cr) %Cred%d' --date-order";
      grep = "grep -Ii";
      hist = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      history = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      # Shows the commit message and files changed from the latest commit
      latest = "!git ll -1";
      lds = "log --pretty=format:'%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --date=short";
      lost = "fsck --lost-found";
      # A better git log.
      ls = "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate";
      # Moves a set of commits from the current branch to another
      rba = "rebase --abort";
      rbc = "!f(){ git add -A && git rebase --continue; }; f";
      re = "!f(){ DEFAULT=$(git default); git fetch origin && git rebase origin/\${1-$DEFAULT}; }; f";
      remotes = "remote -v";
      restore = "!f(){ git add -A && git commit -qm 'RESTORE SAVEPOINT'; git reset $1 --hard; }; f";
      ri = "!f(){ DEFAULT=$(git default); git fetch origin && git rebase --interactive origin/\${1-$DEFAULT}; }; f";
      save = "!git add -A && git commit -m 'SAVEPOINT'";
      set-origin = "remote set-url origin";
      set-upstream = "remote set-url upstream";
      st = "status -s";
      stashes = "stash list";
      sync = "!git pull --rebase && git push";
      undo = "reset HEAD~1 --mixed";
      # Unstage a file
      unstage = "reset -q HEAD --";
      up = "!git pull --rebase --prune $@ && git submodule update --init --recursive";
      wip = "commit -am 'WIP'";
      wipe = "!f() { rev=$(git rev-parse \${1-HEAD}); git add -A && git commit --allow-empty -qm 'WIPE SAVEPOINT' && git reset $rev --hard; }; f";
    };
  };
}
