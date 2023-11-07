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
in
{
  home.packages = with pkgs;[
    awscli2        # the worst official aws cli
    k9s            # nicer kubectl
    terraform-ls   # lsp for terraformation
    terraform-docs # documentation for terraform things
    pre-commit     # overengineered frameworks for simple things :facepalm:
  ];
}
