{ inputs, ... }: {
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "25.05"; }

    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x280
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default

    ./configuration.nix
  ];
}
