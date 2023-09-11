{ inputs
, cell
}: {
  horus = {
    networking.hostName = "horus";
    deployment = {
      tags = [ "wsl" "horus" "local" ];
      allowLocalDeployment = true;
      targetHost = "localhost";
    };
    imports = [ cell.nixosConfigurations.horus ];
  };
}
