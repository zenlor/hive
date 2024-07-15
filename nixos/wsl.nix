{...}: {pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    ibm-plex
  ];
}
