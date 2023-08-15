{
  nix.settings.connect-timeout = 5;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.log-lines = lib.mkDefault 5;

  # keep disk clean
  nix.settings.max-free = lib.mkDefault (1000 * 1000 * 1000);
  nix.settings.min-free = lib.mkDefault (128 * 1000 * 1000);

  # speed up containers
  nix.daemonCPUSchedPolicy = lib.mkDefault "batch";
  nix.daemonIOSchedClass = lib.mkDefault "idle";
  nix.daemonIOSchedPriority = lib.mkDefault 7;

  # avoid eccessive ssh network chatter while building
  nix.settings.builders-use-substitutes = true;
}
