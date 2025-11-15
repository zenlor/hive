{
  lib,
  pkgs,
  ...
}: {
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
    blueman
    xwayland-satellite
    # default applications
    gnome-keyring
    file-roller
    zathura
    nautilus
    # flatpak
    gnome-software

    # wayland
    wl-clipboard
  ];

  services.dbus.packages = [pkgs.nautilus];

  services.udisks2.enable = true;
  services.gnome.gnome-settings-daemon.enable = true;
  programs.gnome-disks.enable = true;
  programs.file-roller.enable = true;

  # do I need this?
  # services.displayManager = {
  #   sddm.enable = true;
  #   sddm.wayland.enable=true;
  # };
  #
  # do I need this for gdm?
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };

  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gnome
    pkgs.xdg-desktop-portal-gtk
  ];
  xdg.portal.config.common.defaults = "gnome";
}
