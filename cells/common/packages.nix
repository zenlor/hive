{ inputs
, cell
, ...
}:
let
  inherit (inputs) haumea;
in
if builtins.pathExists ./packages
then
  haumea.lib.load
  {
    src = ./packages;
    inputs = { inherit inputs cell; };
    transformer = haumea.lib.transformers.liftDefault;
  }
else { }
