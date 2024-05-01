{ ... }:
{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.wayland = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    layout = "us";
    xkbVariant = "";
  };

  programs.geary.enable = true;
  programs.file-roller.enable = true;

  services.gnome = {
    gnome-initial-setup.enable = true;
    core-os-services.enable = true;
    core-utilities.enable = true;
    sushi.enable = true;
    tracker.enable = true;
    gnome-keyring.enable = true;
    gnome-user-share.enable = true;
    gnome-browser-connector.enable = true;
  };

  services.gvfs.enable = true;
  programs.gphoto2.enable = true;

  # boxes might break
  environment.systemPackages = with pkgs; [ gnome.gnome-boxes ];
}
