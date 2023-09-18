{ inputs, ... }:
{
  imports = [ inputs.doom-emacs.hmModule ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };
}
