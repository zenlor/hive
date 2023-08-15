{ inputs
, cell
}: {
  weasel = {
    networking.hostName = "weasel";
    deployment = {
      tags = [ "wsl" "weasel" "local" ];
      allowLocalDeployment = true;
      targetHost = "localhost";
    };
    imports = [ cell.nixosConfigurations.weasel ];
  };
}
