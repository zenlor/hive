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
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  environment.systemPackages = with pkgs; [
    helvum
  ];

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
  services.flatpak = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };


  # Appimage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
