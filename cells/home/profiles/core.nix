{ inputs
, ...
}:
let
  inherit (inputs)
    nixpkgs
    ;
  stateVersion = "23.05";
in
{
  xdg.enable = true;

  home.stateVersion = stateVersion;

  home.packages = with nixpkgs; [
    elinks
  ];

  home.sessionVariables = {
    # go
    GOPATH = "$HOME/lib";

    # browser
    XDG_BROWSER = "elinks";
  };
}
