{ super, root, inputs, stateVersion, ... }:
{
  system.stateVersion = stateVersion;

  imports = [
    root.core
  ];
}

