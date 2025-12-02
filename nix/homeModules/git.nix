{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ghq
    gitu
    git-extras
    git-stack
    tig
    git-branchless
    git-branchstack
  ];

  programs.git = {
    enable = true;

    ignores = [
      ".dir-locals.el"
      ".DS_Store"
      ".lsp"
      ".clj-kondo"
      ".direnv"
    ];

    settings.aliases = {
      fixup = ''!f() { TARGET=$(git rev-parse "$1"); git commit --fixup=$TARGET ''${@:2} && EDITOR=true git rebase -i --autostash --autosquash $TARGET^; }; f'';
      co = "checkout";
      st = "status";
      l = "log --date=format:'%a %b %e, %Y' --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cd%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --graph";
      cl = "!ghq get";
      z = "!lazygit";
    };

    settings = {
      core.autocrlf = "input";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "current";
      push.autoSetupRemote = true;
      rebase.autosquash = true;
      rerere.enabled = true;
      merge.conflictStyle = "diff3";
      status.submoduleSummary = true;
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "$HOME/.ssh/allowed-signers";
      help.autocorrect = 0;
      ghq.root = "$HOME/lib/src";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
    extensions = [ pkgs.gh-eco ];
  };
}
