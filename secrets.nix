let
  lor =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr";
  frenz =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOLvgspK/0rp4Sz7ZWNMW6CioSfCBH7bKE72HoU8vim";
  nasferatu =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOthdftwPv6orliN61tTzcSC89L1uvHdT4d8+ErXlndt";
  horus =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAly76ldEsrk0wikYNe1NDqdQLo8K7EkbfDL3LUl4XqL";

  all = [ lor frenz nasferatu horus ];
in
{
  # wireguard
  "secrets/wireguard/wg-frenz.age".publicKeys = [ lor frenz ];
  "secrets/wireguard/wg-nasferatu.age".publicKeys = [ lor nasferatu ];
  "secrets/wireguard/wg-pad.age".publicKeys = [ lor ];
  "secrets/wireguard/wg-horus.age".publicKeys = [ lor ];

  # bot secrets
  "secrets/services/marrano-bot.age".publicKeys = all;

  # user secrets
  "secrets/users/lor.age".publicKeys = all;
  "secrets/users/root.age".publicKeys = all;
}
