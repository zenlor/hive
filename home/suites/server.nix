{ super, root, inputs, stateVersion, ... }:
{ ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.lor = {
      imports = [
        root.core
        root.shell.core
        root.shell.fish
        root.shell.tmux
        root.shell.nnn
        root.shell.zellij
        root.shell.btop
        root.shell.bottom

        root.helix
        root.neovim
      ];
      home.stateVersion = "${stateVersion}";
    };
  };
}
