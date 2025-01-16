{ ... }:
{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      fish_config theme choose "Tomorrow Night"

      function fish_title
          if set -q argv[1]
              echo $argv[1]
          else
              prompt_pwd
          end
      end

      set --universal pure_shorten_prompt_current_directory_length 1
      set --universal pure_enable_single_line_prompt true
      fish_vi_key_bindings
    '';
    plugins = [
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
    ];
  };
}
