{
  description = "nixos bee hive";

  outputs =
    {
      self,
      flakelight,
      flakelight-darwin,
      nixpkgs,
      deploy-rs,
      helix,
      agenix,
      ...
    }@inputs:
    flakelight ./. {
      inherit inputs;

      nixDir = ./nix;

      imports = [
        flakelight-darwin.flakelightModules.default
      ];
      systems = nixpkgs.lib.systems.flakeExposed;

      withOverlays = [
        helix.overlays.helix
        agenix.overlays.default
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
      checks = { };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flakelight.url = "github:nix-community/flakelight";
    flakelight.inputs.nixpkgs.follows = "nixpkgs";
    flakelight-darwin.url = "github:zenlor/flakelight-darwin?ref=fix/systems";
    # flakelight-darwin.url = "github:cmacrae/flakelight-darwin";
    flakelight-darwin.inputs.flakelight.follows = "flakelight";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    marrano-bot.url = "github:moolite/bot";
    marrano-bot.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix/release-25.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:nix-community/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
  };
}
