{...}: {
  services.fail2ban = {
    enable = true;
  };
  services.openssh.settings.LogLevel = "VERBOSE";
}
