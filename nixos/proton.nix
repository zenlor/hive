{ ... }: { pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    protonvpn-cli
    protonvpn-gui
    proton-pass
  ];
}
