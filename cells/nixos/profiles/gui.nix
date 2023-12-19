{ inputs
, ...
}:
let
  inherit (inputs.nixpkgs)
    self
    config
    lib
    pkgs
    ;
in
{
  environment = {
    systemPackages = with pkgs; [
      sway
      thunderbird
      mako
      wl-clipboard
      shotman
      alacritty
    ];
  };

  security.polkit.enable = true;
  hardware.opengl.enable = true;

  sound.enable = true;
  config.pulseaudio = true;
  hardware.pulseaudio.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4"; # super
      terminal = "alacritty";
      output = {
        "Virtual-1" = {
          mode = "1920x1080@60Hz";
        };
      };
    };
    extraConfig = ''
      bindsym Print               exec shotman -c output
      bindsym Print+Shift         exec shotman -c region
      bindsym Print+Shift+Control exec shotman -c window
    '';
  };

  services.tuigreet = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd sway
      '';
    };
  };
  environment.etc."greetd/environments".text = "sway";
}
