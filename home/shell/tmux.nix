{ ... }:
{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";

    clock24 = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;

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

      set -g window-status-format " #I:#W "
      set -g window-status-current-format "#[bg=#698DDA,fg=#000000] #I:#W "

      # keybindings
      bind-key a last-window
      ## pane splitting.
      bind v split-window -h -c "#{pane_current_path}"
      bind b split-window -v -c "#{pane_current_path}"

    '';

    plugins = with pkgs; [ tmuxPlugins.tmux-fzf ];
  };
}
