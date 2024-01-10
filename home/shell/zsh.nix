{ ... }:
{ pkgs, ... }: {
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

      if [ "$TMUX" = "" ]; then
          tmux -u -2 attach || tmux -2 -u
      fi

      export GPG_TTY=$(tty)
    '';

    initExtra = ''

      # case insensitive matching for lower-case letters
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      e()     { pgrep '[Ee]macs' && emacsclient -n "$@" || emacs -nw "$@" }
      ediff() { emacs -nw --eval "(ediff-files \"$1\" \"$2\")"; }
      eman()  { emacs -nw --eval "(switch-to-buffer (man \"$1\"))"; }
      ekill() { emacsclient --eval '(kill-emacs)'; }

      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      # fix zsh-vi-mode overwriting fzf
      function zvm_after_init() {
        zvm_bindkey viins '^R' fzf-history-widget
      }

      unset RPS1 # this is set somewhere in osx ... looking for the offender...
      autoload -Uz add-zsh-hook
      _iay_prompt() {
        # PROMPT="$(${pkgs.iay}/bin/iay -zm)" # regular variant
        PROMPT="$(${pkgs.iay}/bin/iay -zm)"   # miminal variant
      }
      add-zsh-hook precmd _iay_prompt
    '';

    localVariables = {
      CLICOLOR = "1";
      EDITOR = "nvim";
    };

  };

  home.packages = with pkgs; [
    zsh-vi-mode
    zsh-autopair
    zsh-fast-syntax-highlighting
    iay
  ];
}
