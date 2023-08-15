let
  lor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr";
  frenz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOLvgspK/0rp4Sz7ZWNMW6CioSfCBH7bKE72HoU8vim";
  nasferatu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOthdftwPv6orliN61tTzcSC89L1uvHdT4d8+ErXlndt";
  weasel = "";

  all = [ lor frenz nasferatu weasel ];
in
{
  "wg-frenz.age".publicKeys = [ lor frenz ];
  "wg-nasferatu.age".publicKeys = [ lor nasferatu ];
  "marrano-bot.age".publicKeys = [ lor frenz nasferatu ];
  "root.age".publicKeys = all;
}
