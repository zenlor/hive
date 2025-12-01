{ inputs, ... }:
{
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "25.05"; }
    { nixpkgs.overlays = [ inputs.marrano-bot.overlays.default ]; }

    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default

    ./configuration.nix
  ];
}
