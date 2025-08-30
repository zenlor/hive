{ inputs, pkgs, ... }: {
  services = {
    pulseaudio.enable = false;
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
