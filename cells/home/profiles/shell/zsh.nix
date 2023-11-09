{ inputs
, ...
}:
let
  inherit (inputs)
    nixpkgs
    ;
in
{
  programs.zsh = {
    enable = true;

    dotDir = "/.config/zsh";

    autocd = true;
    enableVteIntegration = true;
    enableAutosuggestions = false;
    enableCompletion = true;
    historySubstringSearch.enable = true;
    history.share = true;
    history.ignoreDups = true;
    history.ignoreSpace = true;

    shellGlobalAliases = {
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../...";
    };

    profileExtra = ''
      if [ $TERM = tramp ]; then
              unset RPROMPT
              unset RPS1
              PS1="$ "
              unsetopt zle
              unsetopt rcs  # Inhibit loading of further config files
      fi
    '';

    initExtra = ''
      if [ "$TMUX" = "" ]; then
          tmux -u attach || tmux -u
      fi

      export GPG_TTY=$(tty)

      # case insensitive matching for lower-case letters
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      e()     { pgrep '[Ee]macs' && emacsclient -n "$@" || emacs -nw "$@" }
      ediff() { emacs -nw --eval "(ediff-files \"$1\" \"$2\")"; }
      eman()  { emacs -nw --eval "(switch-to-buffer (man \"$1\"))"; }
      ekill() { emacsclient --eval '(kill-emacs)'; }

      ######################################### oh-my-zsh/lib/key-bindings.zsh #########################################
      # Start typing + [Up-Arrow] - fuzzy find history forward
      if [[ "''${terminfo[kcuu1]}" != "" ]]; then
        autoload -U up-line-or-beginning-search
        zle -N up-line-or-beginning-search
        bindkey "''${terminfo[kcuu1]}" up-line-or-beginning-search
      fi
      # Start typing + [Down-Arrow] - fuzzy find history backward
      if [[ "''${terminfo[kcud1]}" != "" ]]; then
        autoload -U down-line-or-beginning-search
        zle -N down-line-or-beginning-search
        bindkey "''${terminfo[kcud1]}" down-line-or-beginning-search
      fi
      bindkey '^[[127;5u' backward-kill-word                  # [Ctrl-Backspace] - delete whole backward-wordf3
      bindkey '^[[127;2u' backward-kill-word                  # [Shift-Backspace] - delete whole backward-word
      bindkey '^[[127;4u' backward-kill-line                  # [Shift-Alt-Backspace] - delete line up to cursor
      bindkey '^[[3;5~' kill-word                             # [Ctrl-Delete] - delete whole forward-word
      bindkey '^[[3;2~' kill-word                             # [Shift-Delete] - delete whole forward-word
      bindkey '^[[3;4~' kill-line                             # [Shift-Alt-Delete] - delete line from cursor
      bindkey '^[[Z' reverse-menu-complete                    # [Shift-Tab] - move through the completion menu backwards
      bindkey '^[[1;5C' forward-word                          # [Ctrl-RightArrow] - move forward one word
      bindkey '^[[1;5D' backward-word                         # [Ctrl-LeftArrow] - move backward one word
      ##################################################################################################################

      source ${nixpkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      autoload -Uz add-zsh-hook
      _iay_prompt() {
        # PROMPT="$(iay -z)"    # regular variant
        PROMPT="$(iay -zm)" # miminal variant
        unset RPROMPT
      }
      add-zsh-hook precmd _iay_prompt
    '';

    localVariables = {
      CLICOLOR = "1";
      EDITOR = "nvim";
    };

  };

  home.packages = with nixpkgs; [
    zsh-vi-mode
    zsh-history
    zsh-fzf-tab
    zsh-autopair
    zsh-fast-syntax-highlighting
    fzf-zsh
    iay
  ];
}
