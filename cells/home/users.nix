{ inputs, cell }:
let
  inherit (inputs)
    nixpkgs
    std
    haumea
    ;
in
{
  darwin = { };
  nixos = {
    lor = { pkgs, ... }: {
      home-manager.users.lor = _: {
        imports = with userProfiles;
          [ minimal devel ]
          ++ modulesImportables;
      };
    };
  };
}
