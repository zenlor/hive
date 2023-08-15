{ inputs
, cell
}:
let
  latest = import inputs.nixpkgs-unstable {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };
in
{
  inherit
    (latest)
    rnix-lsp
    nil
    terraform
    terraform-ls
    statix
    nixUnstable
    cachix
    nix-index
    _1password
    direnv
    nvfetcher
    dive
    ;
}
