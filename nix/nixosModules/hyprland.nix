{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    overskride # bluetooth frontend
    shotman # screenshots

    # wayland tools
    wl-clipboard
    wl-clip-persist
    wl-restart

    fuzzel
    hyprpicker
    hyprcursor
    hyprlock
    hyprpaper
    hyprsunset
    hyprpolkitagent
    hyprnotify
    cava
    waybar

    pwvucontrol
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.uwsm = {
    enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable=true;
}
