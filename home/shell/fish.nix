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

      # delete erroneous commands at shell exit
      set sponge_purge_only_on_exit true

      # hydro settings
      set hydro_multiline false
      set hydro_color_pwd $fish_color_cwd
      set hydro_color_error $fish_color_error
      set hydro_color_prompt $fish_color_operator
      set hydro_color_git $fish_color_redirection

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
        name = "prompt";
        src = pkgs.fishPlugins.hydro.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
    ];
  };
}
