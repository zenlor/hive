{ root, ... }:
{ config, pkgs, lib, ... }: {
  age.secrets.lor-password.file = root.secrets.users.lor;

  users.users.lor = {
    isNormalUser = true;
    description = "Lorenzo";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPasswordFile = lib.mkDefault config.age.secrets.lor-password.path;
    shell = lib.mkForce pkgs.fish;
    packages = with pkgs; [ firefox ];
  };
}
