{ root, stateVersion, ... }:
{
  system.stateVersion = stateVersion;

  # Base programs
  imports = [
    root.core
  ];
}
