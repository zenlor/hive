{ inputs, ... }: {
  system = "aarch64-darwin";
  modules = [
    { system.stateVersion = 5; }

    inputs.home-manager.darwinModules.home-manager

    ./configuration.nix
  ];
}
