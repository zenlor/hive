{ inputs
, cell
, ...
}:
let
  inherit (inputs) haumea;
  part-path = ./modules;
in
if builtins.pathExists part-path
then
  haumea.lib.load
  {
    src = part-path;
    inputs = { inherit inputs cell; };
    transformer = haumea.lib.transformers.liftDefault;
  }
else { }
