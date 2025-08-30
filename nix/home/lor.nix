{ inputs, ... }: {
  system = "x86_64-linux";
  modules = with inputs.homeModules;[
    { home.stateVersion = "25.05"; }

    emacs
    neovim
    helix
    shell
  ];
}
