{ ... }: { pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    protonvpn-cli
    protonvpn-gui
    protonmail-desktop
    proton-pass
  ];
}
