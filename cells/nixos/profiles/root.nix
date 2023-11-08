{ inputs
, cell
}:
{ pkgs, age, ... }:
{
  # Root password
  age.secrets.root-password.file = ../secrets/root.age;
  users.users.root.passwordFile = age.secrets.root.path;
}
