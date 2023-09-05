{ inputs, ... }:
let
  inherit (inputs.nixpkgs)
    self
    config
    lib
    pkgs
    ;
in
{
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.lor = { pkgs, ... }: {
    home.stateVersion = "23.05";
    programs = {
      fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
        '';
        plugins = [
          {
            name = "done";
            src = pkgs.fishPlugins.done.src;
          }
          {
            name = "fzf";
            src = pkgs.fishPlugins.fzf-fish.src;
          }
          {
            name = "hydro";
            src = pkgs.fishPlugins.hydro.src;
          }
          {
            name = "z";
            src = pkgs.fishPlugins.z.src;
          }
        ];
      };

      ssh = {
        enable = true;
        serverAliveInterval = 60;
      };

      git = {
        enable = true;
        extraConfig = {
          push = { default = "current"; };
          pull = { rebase = true; };
        };
      };
    };
  };
}
