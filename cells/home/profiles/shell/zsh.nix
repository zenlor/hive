{ inputs
, ...
}:
let
  inherit (inputs)
    pkgs
    ;
in
{

  programs.direnv.enableZshIntegration = true;
  programs.keychain.enableZshIntegration = true;
  programs.z-lua.enableZshIntegration = true;

  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";
    history.path = "${xdg.dataHome}/zsh/zsh_history";

    autocd = true;
    enableVteIntegration = true;
    enableAutosuggestions = false;
    enableCompletion = true;
    historySubstringSearch.enable = true;
    history.share = true;

    shellAliases = {
      d = "direnv";
      g = "git";
      jc = "journalctl";
      md = "mkdir -p";
      n = "nix";
      rd = "rmdir";
      sc = "systemctl";
      "_" = "sudo ";
      vim = "nvim";
    };

    shellGlobalAliases = {
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../...";
    };

    profileExtra = ''
      [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && source $HOME/.nix-profile/etc/profile.d/nix.sh

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
          tmux attach || tmux
      fi

      export GPG_TTY=$(tty)

      autopair-init

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

      autoload -Uz add-zsh-hook
      _iay_prompt() {
        PROMPT="$(iay -z)"    # regular variant
        # PROMPT="$(iay -zm)" # miminal variant
      }
      add-zsh-hook precmd _iay_prompt

      FAST_HIGHLIGHT[use_brackets]=1
    '';

    localVariables = {
      PROMPT_LEAN_TMUX = "™ ";
      CLICOLOR = "1";
      EDITOR = "vim";
    };

    plugins = with pkgs; [
      zsh-vi-mode
      zsh-history
      zsh-fzf-tab
      zsh-autopair
      zsh-fast-syntax-highlighting
      fzf-zsh
      iay
    ];
  };
}
