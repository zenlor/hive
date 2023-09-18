{ inputs, ... }:
let
  inherit (inputs)
    nixpkgs
    ;
in
{
  home.packages = with nixpkgs; [
    difftastic
  ];

  programs.git = {
    enable = true;

    difftastic = {
      enable = true;
      background = "dark";
      color = "auto";
      display = "side-by-side-show-both";
    };

    ignores = [
      ".dir-locals.el"
      ".envrc"
      ".DS_Store"
      ".lsp"
      ".clj-kondo"
    ];

    aliases = {
      co = "checkout";
      st = "status";
      l = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit";
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

      log.decorate = "short";
    };
  };

  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
    extensions = [
      nixpkgs.gh-eco
    ];
  };
}
