let
  frenz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOLvgspK/0rp4Sz7ZWNMW6CioSfCBH7bKE72HoU8vim";
  nasferatu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOthdftwPv6orliN61tTzcSC89L1uvHdT4d8+ErXlndt";

  hosts = [ frenz nasferatu ];
in
{
  "wg-frenz.age".publicKeys = frenz;
  "wg-nasferatu.age".publicKeys = nasferatu;
  "root.age".publicKeys = hosts;
}
