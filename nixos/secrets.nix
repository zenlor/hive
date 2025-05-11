{
  users = {
    lor = ../secrets/users/lor.age;
    root = ../secrets/users/root.age;
  };

  wireguard = {
    networkMask = "10.69.0.0/24";
    allowedIPs = [ "10.69.0.0/24" ];
    endpoint = "frenz.click:51820";

    # hosts
    frenz = {
      ip = "10.69.0.1";
      key = ../secrets/wireguard/wg-frenz.age;
      pub = ../secrets/wireguard/wg-frenz.pub;
    };
    nasferatu = {
      ip = "10.69.0.2";
      key = ../secrets/wireguard/wg-nasferatu.age;
      pub = ../secrets/wireguard/wg-nasferatu.pub;
    };
    pad = {
      ip = "10.69.0.3";
      key = ../secrets/wireguard/wg-pad.age;
      pub = ../secrets/wireguard/wg-pad.pub;
    };
    horus = {
      ip = "10.69.0.4";
      key = ../secrets/wireguard/wg-horus.age;
      pub = ../secrets/wireguard/wg-horus.pub;
    };
    deck = {
      ip = "10.69.0.5";
      key = ../secrets/wireguard/wg-deck.age;
      pub = ../secrets/wireguard/wg-deck.pub;
      # pub = "lBWT6R8VZ75iDG1snAEHSL7gwJgHzYV83AxrppHUhUA=";
    };
    meila = {
      ip = "10.69.0.6";
      key = ../secrets/wireguard/wg-meila.age;
      pub = ../secrets/wireguard/wg-horus.pub;
    };
    # marrani
    marrani-suppah = {
      ip = "10.69.0.133";
      key = ../secrets/wireguard/marrani-suppah.age;
      pub = ../secrets/wireguard/marrani-suppah.pub;
    };
    marrani-krs = {
      ip = "10.69.0.134";
      key = ../secrets/wireguard/marrani-krs.age;
      pub = ../secrets/wireguard/marrani-krs.pub;
    };
    marrani-lukke = {
      ip = "10.69.0.135";
      key = ../secrets/wireguard/marrani-lukke.age;
      pub = ../secrets/wireguard/marrani-lukke.pub;
    };
  };

  services = { marrano-bot = ../secrets/services/marrano-bot.age; };
}
