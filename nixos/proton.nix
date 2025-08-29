{ ... }: { pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    protonvpn-cli
    # protonvpn-gui # Fck electron!
    # proton-pass   # ""
  ];
}
