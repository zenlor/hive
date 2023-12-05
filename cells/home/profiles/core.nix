{ inputs
, ...
}:
let
  inherit (inputs)
    nixpkgs-unstable
    nixpkgs
    ;
  unstable = import nixpkgs-unstable {
    inherit (nixpkgs) system;
  };

  stateVersion = "23.11";
in
{
  xdg.enable = true;

  home.stateVersion = stateVersion;

  home.packages = with unstable;[
  ];

  home.sessionVariables = {
    # go
    GOPATH = "$HOME/lib";

    # browser
    XDG_BROWSER = "elinks";
  };
}
