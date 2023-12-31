{ inputs, ... }:
let
  inherit (inputs)
    nixpkgs
    ;
  inherit (nixpkgs)
    lib
    ;
in
{
  programs.zsh = {
    enableCompletion = true;
    autosuggestions.enable = true;
  };

  programs.fish = {
    enable = true;
    useBabelfish = lib.mkDefault true;
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
  };

  # command-not-found and friends are useless
  programs.command-not-found.enable = false;
  programs.nix-index.enable = false;

  users.defaultUserShell = nixpkgs.zsh;

  # Editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
