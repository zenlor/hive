{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    overskride # bluetooth frontend
    shotman # screenshots

    # wayland tools
    wl-clipboard
    wl-clip-persist
    wl-restart
    wlr-randr
    wl-screenrec

    fuzzel
    hyprpicker
    hyprcursor
    hyprlock
    hyprpaper
    hyprsunset
    hyprpolkitagent
    hyprnotify
    mako
    cava
    waybar
    wttrbar

    pwvucontrol
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  programs.uwsm = {
    enable = true;
  };

  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable=true;
  };
}
