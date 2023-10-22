{ config
, pkgs
, ...
}: {
  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = ["0.0.0.0"];
        ip-transparent = "yes";

        private-domain = "h.frenz.click";
        local-zone = ["h.frenz.click" "static"];
        local-data = [
          "*.h.frenz.click IN A 192.168.1.1"
        ];
      };
      remote-control = {
        control-enable = "yes";
      };

    };
  };
}
