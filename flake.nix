{
  description = "nixos bee hive";

  outputs = inputs @ { self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      imports = [
        inputs.nixos-flake.flakeModule
        inputs.flake-root.flakeModule
      ];

      perSystem =
        { config
        , inputs'
        , pkgs
        , system
        , ...
        }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              inputs.devshell.overlays.default
              inputs.ragenix.overlays.default
            ];
          };
        in
          {
            devShells = {
              default = pkgs.devshell.mkShell {
                packages = with pkgs; [
                  nixd
                  age
                ];
                commands = [
                  { package = pkgs.alejandra; }
                  { package = pkgs.colmena; }
                  { package = pkgs.ragenix; }
                ];
              };
            };
          };

      flake =
        let
          stateVersion = "23.11";
          darwinStateVersion = 4;
          homeStateVersion = "23.11";

          overlays = [
            inputs.ragenix.overlays.default
          ];
        in
          {
            # Configurations for Linux (NixOS) machines
            nixosConfigurations = {
              horus = self.nixos-flake.lib.mkLinuxSystem {
                nixpkgs.hostPlatform = "x86_64-linux";
                nixpkgs.system = "x86_64-linux";
                nixpkgs.overlays = overlays;
                imports = [
                  inputs.nixos-wsl.nixosModules.wsl
                  inputs.ragenix.nixosModules.default
                  inputs.home-manager.nixosModules.default

                  self.nixosModules.core

                  ./profiles/horus

                  self.nixosModules.home-manager
                  self.homeModules.suites.workstation
                ];
              } // {
                deployment = {
                  targetHost = null;
                  allowLocalDeployment = true;
                };
              };
              pad = self.nixos-flake.lib.mkLinuxSystem {
                nixpkgs.hostPlatform = "x86_64-linux";
                nixpkgs.system = "x86_64-linux";
                nixpkgs.overlays = overlays;
                imports = [
                  inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x280
                  inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
                  inputs.ragenix.nixosModules.default
                  inputs.home-manager.nixosModules.default

                  self.nixosModules.core
                  self.nixosModules.laptop

                  ./profiles/pad

                  self.nixosModules.home-manager
                  self.homeModules.suites.workstation
                ];
              } // {
                deployment = {
                  targetHost = null;
                  allowLocalDeployment = true;
                };
              };

              nasferatu = self.nixos-flake.lib.mkLinuxSystem {
                nixpkgs.hostPlatform = "x86_64-linux";
                nixpkgs.system = "x86_64-linux";
                nixpkgs.overlays = overlays;
                imports = [
                  inputs.nixos-hardware.nixosModules.common-cpu-amd
                  inputs.nixos-hardware.nixosModules.common-gpu-amd
                  inputs.nixos-hardware.nixosModules.common-pc-ssd
                  inputs.ragenix.nixosModules.default
                  inputs.home-manager.nixosModules.default

                  self.nixosModules.core
                  self.nixosModules.networking
                  self.nixosModules.openssh

                  ./profiles/nasferatu

                  self.nixosModules.home-manager
                  self.homeModules.suites.server
                ];
              } // {
                deployment = {
                  targetHost = "192.168.1.1";
                  allowLocalDeployment = true;
                };
              };

              frenz = self.nixos-flake.lib.mkLinuxSystem {
                nixpkgs.hostPlatform = "x86_64-linux";
                nixpkgs.system = "x86_64-linux";
                nixpkgs.overlays = overlays;
                imports = [
                  inputs.nixos-hardware.nixosModules.common-cpu-intel
                  inputs.nixos-hardware.nixosModules.common-gpu-intel
                  inputs.nixos-hardware.nixosModules.common-pc-ssd
                  inputs.ragenix.nixosModules.default

                  self.nixosModules.core
                  self.nixosModules.services.marrano-bot

                  ./profiles/frenz

                  self.nixosModules.home-manager
                  self.homeModules.suites.server
                ];
              } // {
                deployment = {
                  targetHost = "frenz.click";
                  allowLocalDeployment = true;
                };
              };

              pprint-a = self.nixos-flake.lib.mkLinuxSystem {
                nixpkgs.hostPlatform = "aarch64-linux";
                nixpkgs.system = "aarch64-linux";
                nixpkgs.overlays = overlays;
                imports = [
                  inputs.nixos-hardware.nixosModules.raspberry-pi-4

                  self.nixosModules.core

                  ./profiles/pprint
                ];
              } // {
                deployment = {
                  targetHost = null; # "192.168.1.10";
                  allowLocalDeployment = true;
                };
              };
            };

            # Configurations for macOS machines
            darwinConfigurations = {
              macbook = self.nixos-flake.lib.mkMacosSystem {
                nixpkgs.hostPlatform = "aarch64-darwin";
                imports = [
                  self.nixosModules.core
                  self.nixosModules.darwin

                  ./profiles/macbook

                  self.darwinModules_.home-manager
                  {
                    home-manager.users.lor = {
                      imports = [
                        self.homeModules.core
                        self.homeModules.darwin
                      ];
                      home.stateVersion = homeStateVersion;
                    };
                  }
                ];

              };
            };

            nixosModules = inputs.haumea.lib.load {
              src = ./nixos;
              inputs = {
                inherit inputs;
                inherit stateVersion;
              };
              transformer = inputs.haumea.lib.transformers.liftDefault;
            };

            homeModules = inputs.haumea.lib.load {
              src = ./home;
              inputs = {
                inherit inputs;
                inherit stateVersion;
              };
              transformer = inputs.haumea.lib.transformers.liftDefault;
            };

            colmena = {
              meta = {
                description = "void-space hive";
                nodeNixpkgs = builtins.mapAttrs (name: value: value._module.specialArgs) self.nixosConfigurations;
                nodeSpecialArgs = builtins.mapAttrs (name: value: value._module.specialArgs) self.nixosConfigurations;
              };
            }// builtins.mapAttrs(name: value: { imports = value._module.args.modules; }) self.nixosConfigurations;
          };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin.url = "github:LnL7/nix-darwin";

    nixpkgs-unfree.url = "github:numtide/nixpkgs-unfree";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";

    nixos-flake.url = "github:srid/nixos-flake";

    nur.url = "github:nix-community/NUR";

    haumea.url = "github:nix-community/haumea?ref=v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";
    colmena.inputs.stable.follows = "nixpkgs";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.flake-utils.follows = "flake-utils";

    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs";

    marrano-bot.url = "github:moolite/bot";
    marrano-bot.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-trusted-substituters = [
      "https://cache.garnix.io"
      "https://cachix.org/api/v1/cache/emacs"
      "https://colmena.cachix.org"
      "https://nix-community.cachix.org"
      "https://numtide.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
