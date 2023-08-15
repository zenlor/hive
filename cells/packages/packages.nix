{ inputs
, cell
, ...
}:
let
  inherit (inputs) nixpkgs haumea;
in
nixpkgs.lib.mapAttrs
  (
    _: v: nixpkgs.callPackage v {
      inputs = inputs;
      nixpkgs = import nixpkgs { inherit (nixpkgs) system; };
      sources = nixpkgs.callPackage ./sources/generated.nix { };
    }
  )
  (
    haumea.lib.load {
      src = ./packages;

      loader = haumea.lib.loaders.path;
    }
  )
