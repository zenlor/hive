{ ... }:
{ pkgs, ... }: {
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.dconf.enable = true;

  # sometimes it's not enabled?
  # hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs.kdePackages; [
    bluedevil
    bluez-qt

    ark
    kmail
    kmail-account-wizard
    kdepim-addons
    kdepim-runtime
    kde-gtk-config

    plasma-browser-integration

    kwave
  ];
}
