{ root, ... }:
{ config, pkgs, lib, ... }: {
  # Root password
  age.secrets.root-password.file = root.secrets.users.lor;
  users.users.root = {
    description = lib.mkForce "Toor";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPasswordFile = lib.mkDefault config.age.secrets.root-password.path;
    shell = lib.mkForce pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO4vpKL4UUOAm9g92tn+Ez6c+zPum4dxm7ocVlyGDskC0/lKa/i+fG/hzzWH3TLvolhyCvzByswGj/eXDnEURaY5yfjd65i7EQGz7GSZb8XCS1/nG7/zdxantsw4a8YdnSDKzCgNWfveXYwmxT9mJi+3jcUbvkL6qTZy9r+Pm+ovmzEwOQex8tx+OCJyfaoD3VjrzWqIW6o16vua5akgs2BnFOMhLkLutf4MoB20ZuXV6RN8A7XoCcQiqxMV68p7z2ACKuXQyuh/UkJARSRKTURLbF00YF9NVh3FNSXOj9m5Nhh8d4P1dGvI1xXZjYF7+YYt4y/dpYS6GIpr3zzkFh lorenzo@frenz"
    ];
  };
}
