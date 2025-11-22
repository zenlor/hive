{ ... }:
{
  # enable dunst
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = "(300,400)";
        height = "(0,200)";
        font = "IBM Plex Sans 14";
      };
    };
  };

  # programs.waybar.settngs.mainBar.layer = "top";
  xdg.configFile."niri/config.kdl".source = ./niri.kdl;
}
