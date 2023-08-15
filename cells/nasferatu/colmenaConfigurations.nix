{ inputs
, cell
}: {
  nasferatu = {
    networking.hostName = "nasferatu";
    deployment = {
      tags = [ "nas" "nasferatu" "local" ];
      allowLocalDeployment = true;
      targetHost = "192.168.1.1";
      buildOnTarget = true;
    };
    imports = [ cell.nixosConfigurations.nasferatu ];
  };
}
