{ super, root, inputs, stateVersion, ... }:
{ config, lib, pkgs, ... }: {

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lorenzo.imports = [
    root.core
    inputs.nur.hmModules.nur

    root.shell.core
    root.shell.fish
    root.shell.tmux
    root.shell.direnv
    root.shell.eza
    root.shell.btop
    root.shell.zoxide
    root.shell.fzf
    root.shell.zsh
    root.shell.nushell

    root.git
    root.ssh

    root.doom
    root.neovim
    root.helix

    root.gui.terminal
  ];

  home-manager.users.lorenzo.programs.keychain.keys = [ "id_ed25519" ];
}
