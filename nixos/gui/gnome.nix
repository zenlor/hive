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
    core-apps.enable = true;
    core-shell.enable = true;
    sushi.enable = true;
    tinysparql.enable = true;
    gnome-keyring.enable = true;
    gnome-user-share.enable = true;
    gnome-browser-connector.enable = true;
    games.enable = true;
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
      lockAll = false;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          clock-format = "24h";
          clock-show-weekday = true;
        };
        "org/gnome/desktop/media-handling" = {
          automount = false;
          automount-open = false;
          autorun-never = true;
        };
        "org/gtk/gtk4/settings/file-chooser" = {
          sort-directories-first = true;
          show-hidden = false;
          view-type = "list";
        };
        "org/gnome/mutter" = {
          edge-tiling = true;
          dynamic-workspaces = true;
          experimental-features = [ "variable-refresh-rate" "scale-monitor-framebuffer" ];
        };
      };
    }];
  };

  # nobody asked for NM to be online :/
  systemd.services.NetworkManager-wait-online.enable = false;

  # HACK:
  # send STOP on suspend to gnome-shell
  # send CONT on resume to gnome-shell
  #
  # somehow still relevant: https://discourse.nixos.org/t/suspend-resume-cycling-on-system-resume/32322/12
  systemd.services = {
    gnome-suspend = {
      description = "suspend gnome shell";
      before = [
        "systemd-suspend.service"
        "systemd-hibernate.service"
        "nvidia-suspend.service"
        "nvidia-hibernate.service"
      ];
      wantedBy = [
        "systemd-suspend.service"
        "systemd-hibernate.service"
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''${pkgs.procps}/bin/pkill -f -STOP ${pkgs.gnome-shell}/bin/gnome-shell'';
      };
    };
    gnome-resume = {
      description = "resume gnome shell";
      after = [
        "systemd-suspend.service"
        "systemd-hibernate.service"
        "nvidia-resume.service"
      ];
      wantedBy = [
        "systemd-suspend.service"
        "systemd-hibernate.service"
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''${pkgs.procps}/bin/pkill -f -CONT ${pkgs.gnome-shell}/bin/gnome-shell'';
      };
    };
  };
}
