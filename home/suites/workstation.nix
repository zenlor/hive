{ super, root, inputs, stateVersion, ... }:
{ ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.lor = {
      imports = [
        root.core
        inputs.nur.hmModules.nur

        root.shell.core
        root.shell.fish
        root.shell.tmux
        root.shell.direnv
        root.shell.exa
        root.shell.zoxide
        root.shell.fzf
        root.shell.nushell

        root.git
        root.ssh

        root.doom
        root.neovim
      ];
      home.stateVersion = "${stateVersion}";
    };
  };
}
