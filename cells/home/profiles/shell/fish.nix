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

      function fish_title
          if [ $_ = 'fish' ]
              echo (prompt_pwd)
          else
              echo $_
          end
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
