{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    {system.stateVersion = "25.05";}

    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-intel

    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default

    ./configuration.nix
  ];
  # specialArgs = {
  #   homeConfigurations = outputs.homeConfigurations;
  # };
}
