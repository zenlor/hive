{ super, root, inputs, stateVersion, ... }:
{ ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.lorenzo = {
      imports = [
        root.users.quantfi
      ];
      home.stateVersion = "${stateVersion}";
    };
  };
}
