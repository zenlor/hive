{
  description = "nixos bee hive";

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ inputs.devshell.overlays.default ];
          allowUnfree = true;
        };
      in {
        devShells.default = pkgs.devshell.mkShell {
          name = "shell";
          env = [ ];
          commands = [
            {
              category = "ops";
              package = pkgs.deploy-rs;
              name = "deploy";
            }
            {
              category = "ops";
              package = inputs.ragenix.packages.${system}.ragenix;
              help = "manage secrets";
            }
            {
              category = "dev";
              package = pkgs.nixd;
            }
            {
              category = "dev";
              package = pkgs.nixpkgs-fmt;
            }
            {
              category = "dev";
              package = pkgs.nixfmt;
            }
            {
              category = "ops";
              package = pkgs.colmena;
            }
          ];
          packages = [ ];
        };

        formatter = pkgs.nixpkgs-fmt;
      }) // {

        nixosConfigurations = {
          horus = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              inputs.nixos-wsl.nixosModules.wsl
              inputs.ragenix.nixosModules.default
              inputs.home-manager.nixosModules.default

              self.nixosModules.core
              self.nixosModules.networking
              self.nixosModules.openssh
              self.nixosModules.users.lor
              self.nixosModules.users.root

              ./profiles/horus

              self.homeModules.suites.workstation
            ];
          };

          pad = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x280
              inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
              inputs.ragenix.nixosModules.default
              inputs.home-manager.nixosModules.default

              self.nixosModules.core
              self.nixosModules.networking
              self.nixosModules.openssh
              self.nixosModules.users.lor
              self.nixosModules.users.root
              self.nixosModules.laptop

              ./profiles/pad

              self.homeModules.suites.workstation
            ];
          };

          nasferatu = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              inputs.nixos-hardware.nixosModules.common-cpu-amd
              inputs.nixos-hardware.nixosModules.common-gpu-amd
              inputs.nixos-hardware.nixosModules.common-pc-ssd
              inputs.ragenix.nixosModules.default
              inputs.home-manager.nixosModules.default

              self.nixosModules.core
              self.nixosModules.networking
              self.nixosModules.openssh
              self.nixosModules.torrent
              self.nixosModules.users.lor
              self.nixosModules.users.root

              ./profiles/nasferatu

              self.homeModules.suites.server
            ];
          };

          frenz = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              inputs.nixos-hardware.nixosModules.common-cpu-intel
              inputs.nixos-hardware.nixosModules.common-gpu-intel
              inputs.nixos-hardware.nixosModules.common-pc-ssd
              inputs.ragenix.nixosModules.default
              inputs.home-manager.nixosModules.default

              self.nixosModules.core
              self.nixosModules.networking
              self.nixosModules.openssh
              self.nixosModules.users.lor
              self.nixosModules.users.root

              inputs.marrano-bot.nixosModules.default
              self.nixosModules.marrano-bot

              ./profiles/frenz

              self.homeModules.suites.server
            ];
          };

          # pprint = inputs.nixpkgs.lib.nixosSystem {
          #     system = "aarch64-linux";
          #     modules = [
          #       inputs.nixos-hardware.nixosModules.raspberry-pi-4
          #       inputs.ragenix.nixosModules.default
          #
          #       self.nixosModules.core
          #
          #       ./profiles/pprint
          #     ];
          #   };
        };

        # Configurations for macOS machines
        darwinConfigurations = {
          macbook = inputs.nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              inputs.ragenix.darwinModules.default

              ./profiles/macbook

              self.homeModules.suites.darwin

              inputs.home-manager.darwinModules.home-manager
              self.nixosModules.users.lgiuliani
            ];

          };
        };

        homeConfigurations.lor = {
          modules = [ self.homeModules.suites.workstation ];
        };

        nixosModules = inputs.haumea.lib.load {
          src = ./nixos;
          inputs = {
            inherit inputs;
            stateVersion = "23.11";
          };
          transformer = inputs.haumea.lib.transformers.liftDefault;
        };

        homeModules = inputs.haumea.lib.load {
          src = ./home;
          inputs = {
            inherit inputs;
            stateVersion = "23.11";
          };
          transformer = inputs.haumea.lib.transformers.liftDefault;
        };

        # colmena = {
        #   meta = {
        #     nixpkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
        #     specialArgs = { inherit nixpkgs; };
        #   };
        # } // builtins.mapAttrs (name: value: {
        #   nixpkgs.system = value.config.nixpkgs.system;
        #   imports = value._module.args.modules;
        # }) (self.nixosConfigurations);

        colmena = let conf = self.nixosConfigurations;
        in {
          meta = {
            description = "my personal machines";
            # This can be overriden by node nixpkgs
            nixpkgs = import inputs.nixpkgs {
              system = "x86_64-linux";
              stateVersion = "23.11";
              allowUnfree = true;
            };
            nodeNixpkgs = builtins.mapAttrs (name: value: value.pkgs) conf;
            nodeSpecialArgs =
              builtins.mapAttrs (name: value: value._module.specialArgs) conf;
          };
          defaults.deployment = {
            buildOnTarget = true;
            allowLocalDeployment = true;
          };
          nasferatu = {
            deployment = {
              tags = [ "nas" "nasferatu" "local" ];
              allowLocalDeployment = true;
              targetHost = "192.168.1.1";
              buildOnTarget = true;
            };
          };
          frenz = {
            deployment = {
              tags = [ "frenz" "vps" "remote" ];
              # allowLocalDeployment = true;
              targetHost = "frenz.click";
              buildOnTarget = true;
            };
          };
          pad = {
            deployment = {
              tags = [ "thinkpad" "local" ];
              allowLocalDeployment = true;
              targetHost = null;
            };
          };
          horus = {
            deployment = {
              tags = [ "wsl" "horus" "local" ];
              allowLocalDeployment = true;
              targetHost = null;
            };
          };
        } // builtins.mapAttrs
        (name: value: { imports = value._module.args.modules; }) conf;
      };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.flake-utils.follows = "flake-utils";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url =
      "github:nix-community/NUR/0880c3c03c2125b267ae20bbf72eb5bebc5a8470";

    haumea.url = "github:nix-community/haumea?ref=v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    colmena.url = "github:zhaofengli/colmena";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs";

    marrano-bot.url = "github:moolite/bot";
    marrano-bot.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-trusted-substituters = [
      "https://cache.garnix.io"
      "https://cachix.org/api/v1/cache/emacs"
      "https://nix-community.cachix.org"
      "https://numtide.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
