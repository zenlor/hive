{ ... }:
{
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = 5; }
    ./configuration.nix
  ];
}
