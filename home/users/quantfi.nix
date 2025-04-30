{ root, stateVersion, ... }:
{
  home.username = "lorenzo";
  home.homeDirectory = "/Users/lorenzo";
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

    root.doom
    root.helix
    root.neovim

    root.dev

    root.terminal.kitty
  ];

  # set kitty font size in darwin
  programs.kitty.font.size = 14;

  # Git settings
  programs.git.extraConfig.user.signingKey = "~/.ssh/id_ed25519.pub";
  # "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOGLWaOeeyPf8Pegp4q/PWCDFgtXoJ5dm4B4Gpw4SjwD";
  programs.git.userName = "Lorenzo Giuliani";
  programs.git.userEmail = "lorenzo@quantfi.tech";
}

