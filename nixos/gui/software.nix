{...}:
{pkgs, ...}: {
  packages = with pkgs; rec [
    telegram-desktop
    firefox
  ];

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
}
