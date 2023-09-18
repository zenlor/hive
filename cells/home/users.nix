{ inputs
, cell
}:
{
  darwin = { };
  nixos = {
    lor = { ... }: {
      home-manager.users.lor = _: {
        imports = with cell.profiles; [
          doom
          neovim
          git
          shell.fish
          shell.zsh
          shell.tmux
        ];
      };
    };
  };
}
