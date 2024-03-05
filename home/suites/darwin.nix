{ super, root, inputs, stateVersion, ... }:
{ config, lib, pkgs, ... }: {

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.lgiuliani = {
      imports = [
        root.core
        inputs.nur.hmModules.nur

        root.shell.core
        root.shell.fish
        root.shell.tmux
        root.shell.direnv
        root.shell.exa
        root.shell.z-lua
        root.shell.fzf
        root.shell.zsh

        root.git
        root.ssh

        root.doom
        root.neovim
      ];
      home.stateVersion = "${stateVersion}";
    };
  };
}
