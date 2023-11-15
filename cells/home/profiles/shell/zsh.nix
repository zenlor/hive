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
          tmux -u -2 attach || tmux -2 -u
      fi

      export GPG_TTY=$(tty)

      # case insensitive matching for lower-case letters
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      e()     { pgrep '[Ee]macs' && emacsclient -n "$@" || emacs -nw "$@" }
      ediff() { emacs -nw --eval "(ediff-files \"$1\" \"$2\")"; }
      eman()  { emacs -nw --eval "(switch-to-buffer (man \"$1\"))"; }
      ekill() { emacsclient --eval '(kill-emacs)'; }

      source ${nixpkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      autoload -Uz add-zsh-hook
      _iay_prompt() {
        # PROMPT="$(${nixpkgs.iay}/bin/iay -zm)" # regular variant
        PROMPT="$(${nixpkgs.iay}/bin/iay -zm)"   # miminal variant
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
    zsh-fzf-tab
    zsh-autopair
    zsh-fast-syntax-highlighting
    iay
  ];
}
