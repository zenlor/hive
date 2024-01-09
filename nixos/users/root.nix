{ root, ... }:
{ config, pkgs, lib, ... }:
{
  # Root password
  age.secrets.root-password.file = root.secrets.users.lor;
  users.users.root = {
    description = "Toor";
    extraGroups = [ "networkmanager" "wheel" ];
    passwordFile = lib.mkDefault config.age.secrets.root-password.path;
    shell = lib.mkForce pkgs.zsh;
  };
}
