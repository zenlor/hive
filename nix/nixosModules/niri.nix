{
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;

  security.polkit.enable = lib.mkDefault true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = { };
  security.pam.services.niri.enableGnomeKeyring = true;
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    fuzzel
    swaylock
    dunst
    swayidle
    swaylock
    swaybg
    blueman
    xwayland-satellite
    wiremix
    impala
    # default applications
    gnome-keyring
    file-roller
    zathura
    nautilus
    # flatpak
    gnome-software
    polkit_gnome

    # wayland
    wl-clipboard
    shotman
  ];

  services.dbus.packages = [ pkgs.nautilus ];

  services.udisks2.enable = true;
  services.gnome.gnome-settings-daemon.enable = true;
  programs.gnome-disks.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

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
