{ ... }:
{ pkgs, ... }: {
  home.packages = with pkgs; [ difftastic ghq git-stack ];

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
      co = "checkout";
      st = "status";
      l =
        "log --date=format:'%a %b %e, %Y' --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cd%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --graph";
      cl = "!ghq get";
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
      help.autocorrect = 50;
      ghq.root = "~/lib/src";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = { enable = true; };
    extensions = [ pkgs.gh-eco ];
  };
}
