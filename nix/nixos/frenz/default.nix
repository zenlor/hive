{ inputs, ... }:
{
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "25.05"; }

    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default

    ./configuration.nix
  ];
}
