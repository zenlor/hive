{ pkgs, ... }:
{
  services.fail2ban = {
    enable = true;
  };
  services.openssh.settings.LogLevel = "VERBOSE";

  environment.systemPackages = with pkgs; [
    neovim
    lnav
  ];
}
