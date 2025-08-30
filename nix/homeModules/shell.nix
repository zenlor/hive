{ pkgs, ... }:
{
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

  programs.bottom = {
    enable = true;
    settings = {
      flags = { regex = true; };
      color = {
        # https://github.com/catppuccin/bottom/blob/main/themes/mocha.toml
        table_header_color = "#f5e0dc";
        all_cpu_color = "#f5e0dc";
        avg_cpu_color = "#eba0ac";
        cpu_core_colors =
          [ "#f38ba8" "#fab387" "#f9e2af" "#a6e3a1" "#74c7ec" "#cba6f7" ];
        ram_color = "#a6e3a1";
        swap_color = "#fab387";
        rx_color = "#a6e3a1";
        tx_color = "#f38ba8";
        widget_title_color = "#f2cdcd";
        border_color = "#585b70";
        highlighted_border_color = "#f5c2e7";
        text_color = "#cdd6f4";
        graph_color = "#a6adc8";
        cursor_color = "#f5c2e7";
        selected_text_color = "#11111b";
        selected_bg_color = "#cba6f7";
        high_battery_color = "#a6e3a1";
        medium_battery_color = "#f9e2af";
        low_battery_color = "#f38ba8";
        gpu_core_colors =
          [ "#74c7ec" "#cba6f7" "#f38ba8" "#fab387" "#f9e2af" "#a6e3a1" ];
        arc_color = "#89dceb";
      };
    };
  };

  programs.fzf = {
    enable = true;

    enableFishIntegration = true;

    colors = {
      bg = "#1e1e1e";
      "bg+" = "#1e1e1e";
      fg = "#d4d4d4";
      "fg+" = "#d4d4d4";
    };

    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'head {}'" ];
    changeDirWidgetCommand = "fd --type d";
  };

  programs.eza = {
    enable = true;
    git = true;
  };
  
  programs.zoxide = {
    enable = true;
    options = [ ];
  };

  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";

    clock24 = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;

    shell = "${pkgs.fish}/bin/fish";

    # muscle-memory is bad
    prefix = "C-a";
    shortcut = "a";

    # modern terminals have rats beside them
    mouse = true;

    # don't let the sessions survive forever!
    secureSocket = true;

    # when attach fails, create a new session
    newSession = true;

    # resize aggressively when using multiple terminals. I have too many
    # devices.
    aggressiveResize = true;

    # Start counting from 1, 0 is too far away (or akward position on atreus
    # keyboards)
    baseIndex = 1;

    # Plugins
    sensibleOnTop = true;

    # escape time for my sanity
    escapeTime = 10;

    # UI
    extraConfig = ''
      # neovim termguicolors
      set-option -sa terminal-features ',XXX:RGB'
      # aggressively renumber windows
      set -g renumber-windows on

      set -g set-titles on

      set -g status-left-length 16
      set -g status-right-length 32

      set -g status-fg colour4
      set -g status-bg colour0

      set -g status-position "top"
      set -g status-style bg=default,fg=default
      set -g status-justify "centre"
      set -g status-left  "#(whoami)"
      set -g status-right "+ %m/%d|%H:%M"

      set -g window-status-format " #I:#T "
      set -g window-status-current-format "#[bg=#698DDA,fg=#000000] #I:#T "

      # keybindings
      bind-key a last-window
      ## pane splitting.
      bind v split-window -h -c "#{pane_current_path}"
      bind b split-window -v -c "#{pane_current_path}"

      set -g default-command "fish"
    '';

    plugins = with pkgs; [ tmuxPlugins.tmux-fzf ];
  };
}
