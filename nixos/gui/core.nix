{ ... }:
{ pkgs, ... }: {

  security.polkit.enable = true;
  hardware.graphics.enable = true;

  # Sound support
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = false;
  };
  # basic terminal emulator
  environment.systemPackages = with pkgs; [ alacritty ];

  # fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      dina-font
      fira-code
      fira-code-symbols
      ibm-plex
      iosevka
      liberation_ttf
      mplus-outline-fonts.githubRelease
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      proggyfonts
      ubuntu_font_family
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto" ];
        sansSerif = [ "Noto" ];
        monospace = [ "Iosevka" ];
      };
    };
  };

  #Flatpak
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
  };
}
