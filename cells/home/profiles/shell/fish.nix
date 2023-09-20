{ inputs
, cell
}:
let
  inherit (inputs)
    nixpkgs
    ;
in
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      if test "$TMUX" = ""
        tmux attach; or tmux
      end
    '';
    plugins = [
      {
        name = "done";
        src = nixpkgs.fishPlugins.done.src;
      }
      {
        name = "fzf";
        src = nixpkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "pure";
        src = nixpkgs.fishPlugins.pure.src;
      }
      {
        name = "z";
        src = nixpkgs.fishPlugins.z.src;
      }
      {
        name = "pisces";
        src = nixpkgs.fishPlugins.pisces.src;
      }
    ];
  };
}
