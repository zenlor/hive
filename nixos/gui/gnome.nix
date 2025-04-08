{ ... }:
{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.wayland = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    xkb.layout = "us";
    xkb.variant = "";
  };

  programs.geary.enable = true;
  programs.file-roller.enable = true;

  services.gnome = {
    gnome-initial-setup.enable = true;
    core-os-services.enable = true;
    core-utilities.enable = true;
    sushi.enable = true;
    tinysparql.enable = true;
    gnome-keyring.enable = true;
    gnome-user-share.enable = true;
    gnome-browser-connector.enable = true;
  };

  services.gvfs.enable = true;
  programs.gphoto2.enable = true;
  programs.seahorse.enable = true;

  # boxes might break
  environment.systemPackages = with pkgs; [
    gnome-boxes
    gnome-tweaks
  ];

  programs.dconf.profiles.user = {
    databases = [{
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          clock-format = "12h";
          clock-show-weekday = true;
        };
        "org/gnome/desktop/media-handling" = {
          automount = false;
          automount-open = false;
          autorun-never = true;
        };
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";
        };
        "org/gtk/gtk4/settings/file-chooser" = {
          sort-directories-first = true;
          show-hidden = true;
          view-type = "list";
        };
        "org/gnome/mutter" = {
          edge-tiling = true;
          dynamic-workspaces = true;
          experimental-features = ["variable-refresh-rate"];
        };
      };
    }];
  };
}
