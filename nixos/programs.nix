{ ... }: { pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    ripgrep
    fd
    jq
    zig
    xh
    janet
    devenv
  ];
}

