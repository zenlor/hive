{
  inputs,
  pkgs,
  ...
}: {
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  services.xserver = {
    enable = true;

    desktopManager.gnome.enable = true;

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    xkb.layout = "us";
    xkb.variant = "";
  };

  programs = {
    geary.enable = true;
    file-roller.enable = true;
    gphoto2.enable = true;
    seahorse.enable = true;
  };

  services.gvfs.enable = true;
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
  };

  environment.systemPackages = with pkgs; [
    evolution
    evolutionWithPlugins
    gnome-boxes
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.applications-menu
    gnome-settings-daemon
  ];

  services.udev.packages = [pkgs.gnome-settings-daemon];

  # HACK: applications being blank
  environment.variables.GSK_RENDERER = "ngl";

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
