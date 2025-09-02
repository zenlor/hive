{ inputs, ... }:
{
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "25.05"; }

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default

    ./configuration.nix
  ];
}
