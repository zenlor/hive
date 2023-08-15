{ inputs
, cell
}: {
  frenz = {
    networking.hostName = "frenz";
    deployment = {
      tags = [ "frenz" "vps" "remote" ];
      # allowLocalDeployment = true;
      targetHost = "frenz.click";
      # buildOnTarget = true;
    };
    imports = [ cell.nixosConfigurations.frenz ];
  };
}
