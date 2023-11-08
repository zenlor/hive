{ inputs
, cell
}: {
  base = { ... }: {
    imports = with cell.profiles; [
      core
      shell.core
      shell.zsh
      shell.ssh
      shell.fzf
      shell.tmux
      # shell.carapace // only in 23.11+/unstable
      git
      neovim
    ];
  };
  workstation = { ... }: {
    imports = with cell.profiles; [
      shell.fish
      shell.direnv
      shell.exa
      shell.z-lua
      doom
    ];
  };
  server = { ... }: {
    imports = with cell.profiles; [
      shell.exa
      neovim
    ];
  };
}
