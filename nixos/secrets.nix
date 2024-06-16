{ ... }: {
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
      pub = "nh7Q89VbgCLLkJBLgRvhApmSu37kOib2x0KMR/LNZUA=";
    };
    nasferatu = {
      ip = "10.69.0.2";
      key = ../secrets/wireguard/wg-nasferatu.age;
      pub = "s50INjeYVKPz7pL3/5iNo1aTGRvqG5mCPEz3QJQkNzI=";
    };
    pad = {
      ip = "10.69.0.3";
      key = ../secrets/wireguard/wg-pad.age;
      pub = "l9bhrR7BU9AdTCeGfhDtyJyb8FMM9pf67s8zTAciRxA=";
    };
    horus = {
      ip = "10.69.0.4";
      key = ../secrets/wireguard/wg-horus.age;
      pub = "JW02K/XfumFo4rtsEgQjgNCin2wNoxEiEQUQpm+ErzE=";
    };
    deck = {
      ip = "10.69.0.5";
      key = ../secrets/wireguard/wg-deck.age;
      pub = "lBWT6R8VZ75iDG1snAEHSL7gwJgHzYV83AxrppHUhUA=";
    };
  };

  services = { marrano-bot = ../secrets/services/marrano-bot.age; };
}
