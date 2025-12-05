{ pkgs, ... }:
{
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;

    wireplumber.enable = true;

    # bluetooth
    wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        # "bluez5.enable-hw-volume" = false;
        "bluez5.enable-hw-volume" = true;
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.roles" = [
          "a2dp_sink"
          "a2dp_source"
          # "bap_sink"
          # "bap_source"
          # "hsp_hs" "hsp_ag"
          # "hfp_hf"
          # "hfp_ag"
        ];
        "bluez5.codecs" = [
          "sbc"
          "sbc_xq"
          "aac"
        ];
        "bluez5.hfphsp-backend" = "native";
      };
    };
    #
    # low-latency default settings
    extraConfig.pipewire = {
      "92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 32;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 8192;
        };
      };
    };
    # low-latency for pipewire-pulse conversion layer
    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "32/48000";
            pulse.max.req = "8192/48000";
            pulse.min.quantum = "32/48000";
            pulse.max.quantum = "8192/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "128/48000";
        resample.quality = 1;
      };
    };
  };

  services.playerctld.enable = true;

  environment.systemPackages = [
    pkgs.helvum
    pkgs.wiremix
  ];
}
