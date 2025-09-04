{ pkgs,... }:
{
  home.sessionVariables = {
    # vim as default editor
    EDITOR = "nvim";
    VISUAL = "hx";

    MANPAGER = "nvim +Man!";
  };

  home.packages = with pkgs;[
    fd
    entr
    rg
  ];
}
