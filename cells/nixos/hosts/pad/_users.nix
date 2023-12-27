{ config
, pkgs
, ... }:
{

  users.users.lor = {
    isNormalUser = true;
    description = "Lorenzo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ firefox ];
  };

}
