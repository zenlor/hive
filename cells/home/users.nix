{ inputs, cell }:
let
  lgiuliani-pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII4awgnF6oRSD0DYJzY7+NWrbIUGTKG8DSk7ogtLEGOb";
  lor-pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr";
in
{
  darwin = {
    lgiuliani = {pkgs, ...}: {
      home-manager.users.lgiuliani = _: {
        imports = with cell.homeSuites; [
          base
          workstation
        ];

        programs.git.extraConfig = {
          user = {
            email = "lgiuliani@malwarebytes.com";
            name = "Lorenzo Giuliani";
            signingKey = "key::${lgiuliani-pubkey}";
          };
        };

        programs.keychain = {
          agents = [ "ssh" ];
          keys = [
            "id_ed25519"
          ];
        };

        home.file = {
          ".ssh/allowed-signers" = {
            text = ''
              lgiuliani@malwarebytes.com ${lgiuliani-pubkey}
            '';
          };
        };
      };
    };
  };
  nixos = {
    lor-server = { pkgs, ... }: {
      home-manager.users.lor = _: {
        imports = with cell.homeSuites; [
          base
          server
        ];

        programs.git.extraConfig = {
          user = {
            email = "lorenzo@frenzart.com";
            name = "Lorenzo Giuliani";
          };
        };

      };

      users.users.lor = {
        isNormalUser = true;
        extraGroups =
          pkgs.lib.mkDefault [
            "wheel"
            "docker"
            "libvirtd"
          ];

        shell = pkgs.zsh;

        openssh.authorizedKeys.keys = [ lor-pubkey ];
      };
    };

    lor = { pkgs, ... }: {
      home-manager.users.lor = _: {
        imports = with cell.homeSuites; [
          base
          workstation
        ];

        programs.git.extraConfig = {
          user = {
            email = "lorenzo@frenzart.com";
            name = "Lorenzo Giuliani";
            signingKey = "key::${lor-pubkey}";
          };
        };

        programs.keychain = {
          agents = [ "ssh" ];
          keys = [
            "id_rsa"
            "id_ecdsa"
            "id_ed25519"
            "id_frenzart.com"
          ];
        };

        home.file = {
          ".ssh/allowed-signers" = {
            text = ''
              lorenzo@frenzart.com ${lor-pubkey}
            '';
          };
        };
      };

      users.users.lor = {
        isNormalUser = true;
        extraGroups =
          pkgs.lib.mkDefault [
            "wheel"
            "audio"
            "video"
            "docker"
            "libvirtd"
            "plugdev"
          ];

        shell = pkgs.fish;

        openssh.authorizedKeys.keys = [
          lor-pubkey
        ];
      };
    };

    root = { pkgs, ... }: {
      users.users.root = {
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO4vpKL4UUOAm9g92tn+Ez6c+zPum4dxm7ocVlyGDskC0/lKa/i+fG/hzzWH3TLvolhyCvzByswGj/eXDnEURaY5yfjd65i7EQGz7GSZb8XCS1/nG7/zdxantsw4a8YdnSDKzCgNWfveXYwmxT9mJi+3jcUbvkL6qTZy9r+Pm+ovmzEwOQex8tx+OCJyfaoD3VjrzWqIW6o16vua5akgs2BnFOMhLkLutf4MoB20ZuXV6RN8A7XoCcQiqxMV68p7z2ACKuXQyuh/UkJARSRKTURLbF00YF9NVh3FNSXOj9m5Nhh8d4P1dGvI1xXZjYF7+YYt4y/dpYS6GIpr3zzkFh"
        ];

        uid = 0;
        shell = pkgs.zsh;
      };
    };
  };
}
