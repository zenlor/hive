{lib, pkgs, ...}:
{
  programs.niri.enable = true;

  security.polkit.enable = lib.mkDefault true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};

  programs.waybar.enable = true; # top bar
  environment.systemPackages = with pkgs; [
    fuzzel
    swaylock
    mako
    swayidle
    swaybg
    xwayland-satellite
  ];

  # do I need this?
  # services.displayManager = {
  #   sddm.enable = true;
  #   sddm.wayland.enable=true;
  # };
}
