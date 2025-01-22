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
        root.neovim
        root.helix

        root.terminal.wezterm
        root.terminal.alacritty

        root.users.lor
      ];
      home.stateVersion = "${stateVersion}";
    };
  };
}
