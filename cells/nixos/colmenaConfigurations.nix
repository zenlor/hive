{ inputs
, cell
}:
let
  inherit (inputs)
    haumea
    ;
in
{
  frenz = {
    networking.hostName = "frenz";
    deployment = {
      tags = [ "frenz" "vps" "remote" ];
      # allowLocalDeployment = true;
      targetHost = "frenz.click";
      buildOnTarget = true;
    };
    imports = [ cell.nixosConfigurations.frenz ];
  };

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

  horus = {
    networking.hostName = "horus";
    deployment = {
      tags = [ "wsl" "horus" "local" ];
      allowLocalDeployment = true;
      targetHost = null;
    };
    imports = [ cell.nixosConfigurations.horus ];
  };

  pad = {
    networking.hostName = "pad";
    deployment = {
      tags = [ "thinkpad" "local" ];
      allowLocalDeployment = true;
      targetHost = null;
    };
    imports = [ cell.nixosConfigurations.pad ];
  };
}
