{super, root, inputs, stateVersion, ... }:
{ ... }: {
  home.username = "lor";
  home.homeDirectory = "/home/lor";
  home.stateVersion = stateVersion;

  programs.home-manager.enable = true;

  imports = [
      root.core

      root.shell.core
      root.shell.fish
      root.shell.tmux
      root.shell.direnv
      root.shell.eza
      root.shell.btop
      root.shell.zoxide
      root.shell.fzf
      root.shell.nnn
      root.shell.nushell
      root.shell.zellij

      root.git
      root.ssh

      root.neovim
      root.helix
      root.doom

      root.dev

      root.terminal.kitty
  ];
   
  # Git settings
  programs.git.extraConfig.user.signingkey = "~/.ssh/id_ed25519.pub";
  # "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr";
  programs.git.userName = "Lorenzo Giuliani";
  programs.git.userEmail = "lorenzo@frenzart.com";
}
