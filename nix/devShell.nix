pkgs:
with pkgs; {
  packages = [
    nixd
    nixfmt-rfc-style
    deploy-rs
    agenix
    wireguard-tools
    home-manager
  ];
}
