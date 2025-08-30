{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard
    wl-clip-persist
    wl-restart
    overskride # bluetooth frontend

    hyprpicker
    hyprcursor
    hyprlock
    hyprpaper
    hyprsunset
    hyprpolkitagent
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.uwsm = {
    enable = true;

    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "${pkgs.hyprland}/bin/Hyprland";
      };
    };
  };
}
