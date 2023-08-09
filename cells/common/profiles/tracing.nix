{ inputs
, cell
}:
let
  inherit (inputs)
    pkgs
    ;
in
{
  programs.bbc.enable = true;
  programs.sysdig.enable = !pkgs.stdenv.isAarch64;
  environment.systemPackages = [
    pkgs.strace

    (pkgs.lowPrio config.boot.kernelPackages.perf)
  ];
}
