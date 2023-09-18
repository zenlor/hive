{ inputs
, cell
}: {
  workstation = { ... }: {
    imports = with cell.profiles; [
      shell.fish
      shell.zsh
      shell.tmux
      shell.nvim
      doom
      git
      ssh
    ];
  };
}
