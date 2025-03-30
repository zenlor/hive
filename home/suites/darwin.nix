{ super, root, inputs, stateVersion, ... }:
{ ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.lor = {
      imports = [
        root.users.quantfi
      ];
      home.stateVersion = "${stateVersion}";
    };
  };
}
