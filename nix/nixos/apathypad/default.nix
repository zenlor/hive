{ ... }:
{
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "25.05"; }
    # ./configuration.nix
  ];
}
