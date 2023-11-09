{ inputs
, cell
}:
let
  inherit (inputs)
    cells
    nixpkgs
    ;
in
{
  config = {
    homebrew = {
      enable = true;
      casks = [
        "zoom"
        "slack"
        "firefox"
      ];
    };
  };
}
