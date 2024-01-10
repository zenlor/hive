{ ... }:
{ pkgs, ... }: {
  environment = { systemPackages = with pkgs; [ thunderbird alacritty ]; };

  security.polkit.enable = true;
  hardware.opengl.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };
}
