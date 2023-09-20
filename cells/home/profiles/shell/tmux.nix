{ inputs, ... }:
let
  inherit (inputs)
    nixpkgs
    ;
in
{
  programs.tmux = {
    enable = true;

    clock24 = true;
    keyMode = "vi";

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

    # UI
    extraConfig = ''
      set -g set-titles on

      set -g status-left-length 32
      set -g status-right-length 150

      set -g status-fg colour4
      set -g status-bg colour0

      set -g status-left '#[fg=colour10,bg=colour0,bold] ❐ #S #[fg=colour8,bg=colour10,italics] #(whoami) #[fg=colour8,bg=colour10]░#[fg=colour10,bg=colour0]░'
      set -g window-status-format "#[bg=colour0]  #I #W "
      set -g window-status-current-format "#[fg=colour8,bg=colour16,bold]░ #I #W "
      set -g status-right "#[nobold]░▒ #(hostname -s) · #(date +'%m%d|%H%M')"
    '';

    plugins = with nixpkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.tmux-fzf
    ];
  };
}