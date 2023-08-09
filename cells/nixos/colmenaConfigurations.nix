{ inputs
, cell
}:
let
  inherit (inputs) haumea nixpkgs;
  l = nixpkgs.lib // builtins;
  hosts = cell.nixosConfigurations;
  overrides = {
    malware = {
      deployment.targetPort = 2222;
    };
  };
in
l.mapAttrs
  (
    name: value:
      value
      // (
        l.recursiveUpdate
          {
            deployment = {
              targetHost = name;
              targetPort = 22;
              targetUser = "lor";
            };
          }
          (
            if overrides ? "${name}"
            then overrides."${name}"
            else { }
          )
      )
  )
  hosts
