{ ... }:
{ pkgs, ... }: {
  home.packages = with pkgs; [ difftastic ghq git-stack git-extras ];

  programs.git = {
    enable = true;

    difftastic = {
      enable = true;
      background = "dark";
      color = "auto";
      display = "side-by-side-show-both";
    };

    ignores = [ ".dir-locals.el" ".DS_Store" ".lsp" ".clj-kondo" ".direnv" ];

    aliases = {
      fixup = ''!f() { TARGET=$(git rev-parse "$1"); git commit --fixup=$TARGET ''${@:2} && EDITOR=true git rebase -i --autostash --autosquash $TARGET^; }; f'';
      co = "checkout";
      st = "status";
      l =
        "log --date=format:'%a %b %e, %Y' --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cd%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --graph";
      cl = "!ghq get";
      z = "!lazygit";
    };

    extraConfig = {
      core.autocrlf = "input";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "upstream";
      push.autoSetupRemote = true;
      rebase.autosquash = true;
      rerere.enabled = true;

      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed-signers";
      help.autocorrect = 0;
      ghq.root = "~/lib/src";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = { enable = true; };
    extensions = [ pkgs.gh-eco ];
  };

  programs.lazygit = {
    enable = true;
    settings = {
      os.editPreset = "nvim";
      gui.nerdFontsVersion = "3";
      git = {
        branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium --oneline {{branchName}} --";
        commitPrefix = {
          pattern = "^\\w+\\/(\\w+-\\w+).*";
          replace = "[$1]";
        };
      };
    };
  };

  programs.gitui = {
    enable = true;
  };
}
