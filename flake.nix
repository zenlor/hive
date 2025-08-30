{
  description = "nixos bee hive";

  outputs =
    {
      self,
      flakelight,
      nixgl,
      flakelight-darwin,
      nixpkgs,
      deploy-rs,
      ...
    }@inputs:
    flakelight ./. {
      withOverlays = [
        nixgl.overlay
      ];

      outputs.deploy.nodes = {
        frenz = {
          hostname = "frenz.click";
          profiles.system = {
            user = "root";
            sshUser = "lor";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.frenz;
          };
        };
        nasferatu = {
          hostname = "192.168.178.2";
          profiles.system = {
            user = "root";
            sshUser = "lor";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nasferatu;
            fastConnection = true;
            autoRollback = true;
          };
        };
        nasanywhere = {
          hostname = "nas.out";
          profiles.system = {
            user = "root";
            sshUser = "lor";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nasferatu;
            fastConnection = true;
            autoRollback = true;
          };
        };
        pad = {
          hostname = "192.168.178.31";
          profiles.system = {
            user = "root";
            sshUser = "lor";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.pad;
          };
        };
      };
    };
  # flakelight ./. (
  #   let
  #     stateVersion = "25.05";
  #     nixosModules = inputs.haumea.lib.load {
  #       src = ./nixos;
  #       inputs = {
  #         inherit inputs;
  #         inherit stateVersion;
  #       };
  #       transformer = inputs.haumea.lib.transformers.liftDefault;
  #     };

  #     homeModules = inputs.haumea.lib.load {
  #       src = ./home;
  #       inputs = {
  #         inherit inputs;
  #         inherit stateVersion;
  #       };
  #       transformer = inputs.haumea.lib.transformers.liftDefault;
  #     };
  #   in
  #   {
  #     imports = [ flakelight-darwin.flakelightModules.default ];
  #     inherit inputs;
  #     systems = nixpkgs.lib.systems.flakeExposed;

  #     devShell.packages = pkgs: [
  #       pkgs.deploy-rs
  #       pkgs.nil
  #       pkgs.nixfmt-rfc-style
  #       pkgs.wireguard-tools
  #       pkgs.alejandra
  #       # pkgs.nixos-install-tools
  #       pkgs.ragenix
  #     ];

  #     homeConfigurations = {
  #       lor = {
  #         system = "x86_64-linux";
  #         modules = [
  #           homeModules.users.lor
  #         ];
  #       };
  #     };

  #     nixosConfigurations = {

  #       horus = inputs.nixpkgs.lib.nixosSystem {
  #         system = "x86_64-linux";
  #         modules = [
  #           inputs.nixos-wsl.nixosModules.wsl
  #           inputs.ragenix.nixosModules.default
  #           inputs.home-manager.nixosModules.default

  #           { system.stateVersion = stateVersion; }

  #           nixosModules.core
  #           nixosModules.networking
  #           nixosModules.openssh
  #           nixosModules.users.lor
  #           nixosModules.users.root

  #           ./profiles/horus

  #           homeModules.suites.workstation
  #         ];
  #       };

  #       pad = inputs.nixpkgs.lib.nixosSystem {
  #         system = "x86_64-linux";
  #         modules = [
  #           inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x280
  #           inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  #           inputs.ragenix.nixosModules.default
  #           inputs.home-manager.nixosModules.default

  #           { system.stateVersion = stateVersion; }

  #           nixosModules.core
  #           nixosModules.networking
  #           nixosModules.openssh
  #           nixosModules.users.lor
  #           nixosModules.users.root
  #           nixosModules.laptop

  #           ./profiles/pad

  #           homeModules.suites.workstation
  #         ];
  #       };

  #       nasferatu = inputs.nixpkgs.lib.nixosSystem {
  #         system = "x86_64-linux";
  #         modules = [
  #           inputs.nixos-hardware.nixosModules.common-cpu-amd
  #           inputs.nixos-hardware.nixosModules.common-gpu-amd
  #           inputs.nixos-hardware.nixosModules.common-pc-ssd
  #           inputs.ragenix.nixosModules.default
  #           inputs.home-manager.nixosModules.default

  #           { system.stateVersion = stateVersion; }

  #           nixosModules.core
  #           nixosModules.networking
  #           nixosModules.monitoring
  #           nixosModules.openssh
  #           nixosModules.torrent
  #           nixosModules.users.lor
  #           nixosModules.users.root

  #           ./profiles/nasferatu

  #           homeModules.suites.server
  #         ];
  #       };

  #       meila = inputs.nixpkgs.lib.nixosSystem {
  #         system = "x86_64-linux";
  #         modules = [
  #           inputs.nixos-hardware.nixosModules.common-cpu-intel
  #           inputs.nixos-hardware.nixosModules.common-pc-ssd
  #           inputs.ragenix.nixosModules.default
  #           inputs.home-manager.nixosModules.default

  #           { system.stateVersion = stateVersion; }

  #           { nixpkgs.overlays = [ inputs.helix.overlays.default ]; }

  #           nixosModules.core
  #           # nixosModules.networking
  #           # nixosModules.network-manager
  #           # nixosModules.openssh

  #           # nixosModules.ollama

  #           nixosModules.users.lor
  #           nixosModules.users.root

  #           nixosModules.qmk_keyboards
  #           nixosModules.gui.core
  #           # nixosModules.gui.gnome
  #           nixosModules.gui.kde
  #           nixosModules.gui.steam
  #           nixosModules.gui.software
  #           nixosModules.gui.nvidia
  #           nixosModules.gui.razer
  #           # nixosModules.gui.plymouth

  #           nixosModules.proton

  #           ./profiles/meila

  #           homeModules.suites.workstation
  #         ];
  #       };

  #       frenz = inputs.nixpkgs.lib.nixosSystem {
  #         system = "x86_64-linux";
  #         modules = [
  #           inputs.nixos-hardware.nixosModules.common-cpu-intel
  #           inputs.nixos-hardware.nixosModules.common-pc-ssd
  #           inputs.ragenix.nixosModules.default
  #           inputs.home-manager.nixosModules.default

  #           { system.stateVersion = stateVersion; }

  #           nixosModules.core
  #           nixosModules.networking
  #           nixosModules.monitoring
  #           nixosModules.openssh
  #           nixosModules.users.lor
  #           nixosModules.users.root

  #           inputs.marrano-bot.nixosModules.default
  #           nixosModules.marrano-bot

  #           ./profiles/frenz

  #           homeModules.suites.server
  #         ];
  #       };
  #     };

  #     # Configurations for macOS machines
  #     darwinConfigurations = {
  #       macbook = inputs.nix-darwin.lib.darwinSystem {
  #         system = "aarch64-darwin";
  #         modules = [
  #           inputs.home-manager.darwinModules.home-manager
  #           inputs.ragenix.darwinModules.default

  #           # nix-darwin requires a number stateVersion
  #           { system.stateVersion = 5; }
  #           { home-manager.backupFileExtension = "nix-backup"; } # FIXME this should not happen!
  #           { home-manager.users.lorenzo.home.stateVersion = stateVersion; }

  #           ./profiles/macbook

  #           # nixosModules.users.lorenzo
  #           homeModules.suites.darwin
  #         ];

  #       };
  #     };
  #     outputs = {
  #       deploy.nodes = {
  #         frenz = {
  #           hostname = "frenz.click";
  #           profiles.system = {
  #             user = "root";
  #             sshUser = "lor";
  #             path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.frenz;
  #           };
  #         };
  #         nasferatu = {
  #           hostname = "192.168.178.2";
  #           profiles.system = {
  #             user = "root";
  #             sshUser = "lor";
  #             path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nasferatu;
  #             fastConnection = true;
  #             autoRollback = true;
  #           };
  #         };
  #         nasanywhere = {
  #           hostname = "nas.out";
  #           profiles.system = {
  #             user = "root";
  #             sshUser = "lor";
  #             path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nasferatu;
  #             fastConnection = true;
  #             autoRollback = true;
  #           };
  #         };
  #         pad = {
  #           hostname = "192.168.178.31";
  #           profiles.system = {
  #             user = "root";
  #             sshUser = "lor";
  #             path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.pad;
  #           };
  #         };
  #       };
  #     };
  #   }
  # );

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # only used in non-nixos linux machines
    # nixgl.url = "github:nix-community/nixGL";
    # nixgl.inputs.nixpkgs.follows = "nixpkgs";

    flakelight.url = "github:nix-community/flakelight";
    flakelight.inputs.nixpkgs.follows = "nixpkgs";
    flakelight-darwin.url = "github:zenlor/flakelight-darwin?ref=fix/systems";
    # flakelight-darwin.url = "github:cmacrae/flakelight-darwin";
    flakelight-darwin.inputs.flakelight.follows = "flakelight";

    haumea.url = "github:nix-community/haumea?ref=main";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs";

    marrano-bot.url = "github:moolite/bot";
    marrano-bot.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";
  };
}
