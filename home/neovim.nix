{ ... }: { pkgs, ... }:
{

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      neovim-remote
      nnn

      # lsp
      ast-grep
      # Telescope
      ripgrep

      # luv
      # NOTE: broken in osx?
      # luajitPackages.luv
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
