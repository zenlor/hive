{ ... }:
{ pkgs, ... }: {

  security.polkit.enable = true;
  hardware.opengl.enable = true;

  # Sound support
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # basic terminal emulator
  environment.systemPackages = with pkgs; [ alacritty ];

  # fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      iosevka
      proggyfonts
      ubuntu_font_family
    ];

    # fontconfig = {
    #   defaultFonts = {
    #     serif = [ "Ubuntu" ];
    #     sansSerif = [ "Ubuntu" ];
    #     monospace = [ "Ubuntu" ];
    #   };
    # };
  };
}
