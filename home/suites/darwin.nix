{ super, root, inputs, stateVersion, ... }:
{ config, lib, pkgs, ... }: {

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lorenzo.imports = [
    root.core
    inputs.nur.hmModules.nur

    root.shell.core
    root.shell.fish
    root.shell.direnv
    root.shell.eza
    root.shell.btop
    root.shell.zoxide
    root.shell.fzf
    root.shell.nushell
    root.shell.tmux
    root.shell.nnn
    root.shell.zellij
    root.shell.bat

    root.git
    root.ssh

    root.doom
    root.neovim
    root.helix

    root.dev

    root.terminal.wezterm
    root.terminal.kitty
    # root.terminal.ghostty # NOTE: not working in darwin

    root.users.quantfi
  ];

  home-manager.backupFileExtension = "bak";

  home-manager.users.lorenzo.programs.keychain.keys = [ "id_ed25519" ];

  # in darwin fonts have different sizes :'(
  home-manager.users.lorenzo.programs.kitty.font.size = 14;
}
