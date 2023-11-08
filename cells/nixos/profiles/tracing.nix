{ inputs
, cell
}:
{ pkgs, config, ... }:
{
  programs.bbc.enable = true;
  programs.sysdig.enable = !pkgs.stdenv.isAarch64;
  environment.systemPackages = [
    pkgs.strace

    (pkgs.lowPrio config.boot.kernelPackages.perf)
  ];
}
