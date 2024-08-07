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
        root.shell.lsd
        root.shell.zoxide
        root.shell.fzf
        # root.shell.zsh
        root.shell.nushell

        root.git
        root.ssh

        root.doom
        root.neovim
        root.helix

        root.gui.terminal
      ];
      home.stateVersion = "${stateVersion}";
    };
  };
}
