{
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
    sushi.enable = true;
    tracker.enable = true;
    gnome-keyring.enable = true;
  };

  services.gnome.gnome-initial-setup.enable = true;
}
