{
  description = "nixos bee hive";

  outputs = { self, flakelight, flakelight-darwin, nixpkgs, deploy-rs, ... }@inputs:
    flakelight ./.
      (
        let
          stateVersion = "24.11";
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
        in
        {
          imports = [ flakelight-darwin.flakelightModules.default ];
          inherit inputs;
          systems = nixpkgs.lib.systems.flakeExposed;

          devShell.packages = pkgs: [
            inputs.ragenix.packages.${pkgs.system}.ragenix
            pkgs.deploy-rs
            pkgs.nil
            pkgs.nixfmt
            pkgs.wireguard-tools
            pkgs.alejandra
          ];

          nixosConfigurations = {

            horus = inputs.nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = [
                inputs.nixos-wsl.nixosModules.wsl
                inputs.ragenix.nixosModules.default
                inputs.home-manager.nixosModules.default

                { system.stateVersion = stateVersion; }

                nixosModules.core
                nixosModules.networking
                nixosModules.openssh
                nixosModules.users.lor
                nixosModules.users.root

                ./profiles/horus

                homeModules.suites.workstation
              ];
            };

            pad = inputs.nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = [
                inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x280
                inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
                inputs.ragenix.nixosModules.default
                inputs.home-manager.nixosModules.default

                { system.stateVersion = stateVersion; }

                nixosModules.core
                nixosModules.networking
                nixosModules.openssh
                nixosModules.users.lor
                nixosModules.users.root
                nixosModules.laptop

                ./profiles/pad

                homeModules.suites.workstation
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

                { system.stateVersion = stateVersion; }

                nixosModules.core
                nixosModules.networking
                nixosModules.openssh
                nixosModules.torrent
                nixosModules.users.lor
                nixosModules.users.root

                ./profiles/nasferatu

                homeModules.suites.server
              ];
            };

            frenz = inputs.nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = [
                inputs.nixos-hardware.nixosModules.common-cpu-intel
                inputs.nixos-hardware.nixosModules.common-pc-ssd
                inputs.ragenix.nixosModules.default
                inputs.home-manager.nixosModules.default

                { system.stateVersion = stateVersion; }

                nixosModules.core
                nixosModules.networking
                nixosModules.openssh
                nixosModules.users.lor
                nixosModules.users.root

                inputs.marrano-bot.nixosModules.default
                nixosModules.marrano-bot

                ./profiles/frenz

                homeModules.suites.server
              ];
            };
          };

          # Configurations for macOS machines
          darwinConfigurations = {
            macbook = inputs.nix-darwin.lib.darwinSystem {
              system = "aarch64-darwin";
              modules = [
                inputs.home-manager.darwinModules.home-manager
                inputs.ragenix.darwinModules.default

                # nix-darwin requires a number stateVersion
                { system.stateVersion = 5; }
                { home-manager.users.lorenzo.home.stateVersion = stateVersion; }

                ./profiles/macbook

                # nixosModules.users.lorenzo
                homeModules.suites.darwin
              ];

            };
          };
        }
      ) // {
      deploy.nodes = {
        frenz = {
          hostname = "frenz.click";
          profiles.system = {
            user = "root";
            sshUser = "lor";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.frenz;
          };
        };
        nasferatu = {
          hostname = "192.168.1.1";
          profiles.system = {
            user = "root";
            sshUser = "lor";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nasferatu;
          };
        };
        pad = {
          hostname = "192.168.1.12";
          profiles.system = {
            user = "root";
            sshUser = "lor";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.pad;
          };
        };
      };
    };


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flakelight.url = "github:nix-community/flakelight";
    flakelight.inputs.nixpkgs.follows = "nixpkgs";
    flakelight-darwin.url = "github:zenlor/flakelight-darwin?ref=fix/systems";
    flakelight-darwin.inputs.flakelight.follows = "flakelight";

    nur.url =
      "github:nix-community/NUR/0880c3c03c2125b267ae20bbf72eb5bebc5a8470";

    haumea.url = "github:nix-community/haumea?ref=v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs";

    marrano-bot.url = "github:moolite/bot";
    marrano-bot.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
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
