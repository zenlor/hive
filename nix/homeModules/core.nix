{ pkgs, ... }:
{
  home.sessionVariables = {
    # vim as default editor
    EDITOR = "nvim";
    VISUAL = "hx";

    MANPAGER = "nvim +Man!";

    NNN_FIFO = "/run/user/1000/nnn.fifo";
  };

  home.shellAliases = {
  };

  home.packages = with pkgs; [
    fd
    entr
    ripgrep
    janet
  ];
}
