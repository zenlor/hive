{
  description = "nixos bee hive";

  # nixos && nixpkgs && home-manager
  inputs = {
    nixpkgs.follows = "nixpkgs-stable";
    nixpkgs-previous.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";

    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    std = {
      url = "github:divnix/std";
      inputs.devshell.follows = "devshell";
      inputs.nixago.follows = "nixago";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.paisano.follows = "paisano";
    };

    hive = {
      url = "github:divnix/hive";
      inputs.colmena.follows = "colmena";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.paisano.follows = "paisano";
    };

    haumea = {
      url = "github:nix-community/haumea?ref=v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixago = {
      url = "github:nix-community/nixago";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    paisano = {
      url = "github:paisano-nix/core";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.stable.follows = "nixpkgs-stable";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.emacs-overlay.follows = "emacs-overlay";
    };

    marrano-bot = {
      url = "github:moolite/bot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , std
    , hive
    , haumea
    , ...
    } @ inputs:
    std.growOn
      {
        inherit inputs;

        systems = [
          "aarch64-darwin"
          "aarch64-linux"
          "x86_64-darwin"
          "x86_64-linux"
        ];

        cellsFrom = ./cells;

        cellBlocks = with std.blockTypes // hive.blockTypes; [
          # Repo utilities
          (devshells "shells")

          # Packages
          (installables "packages")

          # Overlays
          (functions "lib")
          (functions "modules")
          (functions "profiles")
          (functions "overlays")
          (pkgs "overrides")

          # suites/collections
          (functions "darwinSuites")
          (functions "nixosSuites")
          (functions "homeSuites")

          # nixos
          (functions "hardwareProfiles")
          (functions "homeProfiles")
          (functions "users")

          # Configurations
          colmenaConfigurations
          homeConfigurations
          nixosConfigurations
          darwinConfigurations
        ];
      }
      # Utilities
      {
        # Run `nix develop` to enter the devshell
        devShells = hive.harvest self [ "repo" "shells" ];
        packages = hive.harvest inputs.self [
          [ "common" "packages" ]
        ];

        # Useful functions
        lib = hive.pick self [ "common" "lib" ];
      }
      # Modules
      {
        commonModules = std.pick self [ "common" "commonModules" ];
        nixosModules = std.pick self [ "nixos" "modules" ];
        darwinModules = std.pick self [ "darwin" "darwinModules" ];
        homeModules = std.pick self [ "home" "modules" ];
      }
      # Profiles
      {
        commonProfiles = hive.pick self [ "common" "commonProfiles" ];
        nixosProfiles = hive.pick self [ "nixos" "profiles" ];
        darwinProfiles = hive.pick self [ "darwin" "profiles" ];
        homeProfiles = hive.pick self [ "home" "profiles" ];
        devshellProfiles = hive.pick self [ "devshell" "devshellProfiles" ];
      }
      # Configurations
      {
        colmenaHive = hive.collect self "colmenaConfigurations";
        darwinConfigurations = hive.collect self "darwinConfigurations";
        diskoConfigurations = hive.collect self "diskoConfigurations";
        homeConfigurations = hive.collect self "homeConfigurations";
        nixosConfigurations = hive.collect self "nixosConfigurations";
      };

  nixConfig = {
    extra-trusted-substituters = [
      "https://cache.garnix.io"
      "https://cachix.org/api/v1/cache/emacs"
      "https://colmena.cachix.org"
      "https://hyprland.cachix.org"
      "https://microvm.cachix.org"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://nichijou.cachix.org"
      "https://nix-community.cachix.org"
      "https://nixos-cn.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://numtide.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
      "nichijou.cachix.org-1:rbaTU9nLgVW9BK/HSV41vsag6A7/A/caBpcX+cR/6Ps="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
