{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      neovim-remote
      nnn
      ast-grep
      ripgrep
    ];
  };

  # neovim shall be the pager of my man
  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
  };

  # xdg.configFile."nvim/after".source = ./neovim.d/after;
  xdg.configFile."nvim/lua".source = ./neovim.d/lua;
  xdg.configFile."nvim/init.lua".source = ./neovim.d/init.lua;
}
