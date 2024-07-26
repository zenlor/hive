{ ... }:
{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      if test "$TMUX" = ""
        tmux -u -2 attach; or tmux -u -2
      end

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

      theme_gruvbox dark medium
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
      {
        name = "gruvbox";
        src = pkgs.fishPlugins.gruvbox.src;
      }
    ];
  };
}
