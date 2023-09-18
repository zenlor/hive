{ inputs
, cell
}:
let
  pkgs = inputs.nixpkgs;
in
{
  programs.direnv.enableFishIntegration = true;
  programs.keychain.enableFishIntegration = true;
  programs.z-lua.enableFishIntegration = true;

  programs.fish = {
    enable = true;
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
}
