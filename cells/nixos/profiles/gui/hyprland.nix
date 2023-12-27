{ inputs
, ...
}:
let
  inherit (inputs.nixpkgs)
    self
    config
    lib
    pkgs
    ;
in
{
  environment = {
    systemPackages = with pkgs; [
      wl-clipboard
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
