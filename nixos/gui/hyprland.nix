{ ... }:
{ pkgs, ... }: {
  environment = { systemPackages = with pkgs; [ wl-clipboard ]; };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
