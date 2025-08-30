{ inputs, pkgs, ... }: {
  services = {
    pulseaudio.enable = true;
    rtkit.enable = true;
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
  };

  environment.systemPackages = [ pkgs.helvum ];
}
