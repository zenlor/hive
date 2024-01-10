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
        root.shell.z-lua
        root.shell.fzf

        root.doom
        root.neovim
      ];
      home.stateVersion = "${stateVersion}";
    };
  };
}
