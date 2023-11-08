{ inputs
, cell
, ...
}:
let
  inherit (inputs) haumea;
  defaultAsRoot = _: mod: mod.default or mod;
in
if builtins.pathExists ./hosts
then
  haumea.lib.load
  {
    src = ./hosts;
    inputs = { inherit inputs cell; };
    transformer = defaultAsRoot; #haumea.lib.transformers.liftDefault;
  }
else { }
