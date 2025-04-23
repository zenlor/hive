{ ... }:
{ pkgs, ... }: {

  security.polkit.enable = true;
  hardware.graphics.enable = true;

  # Sound support
  services.pulseaudio.enable = false;
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

  # fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      dina-font
      fira-code
      fira-code-symbols
      ibm-plex
      iosevka-bin
      liberation_ttf
      mplus-outline-fonts.githubRelease
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      proggyfonts
      ubuntu_font_family
      comic-neue
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
