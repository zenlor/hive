{ inputs, ... }:
{
  home-manager.backupFileExtension = "backup";
  home-manager.useGlobalPkgs = true;
  home-manager.users.lor = {
    # inherit (pkgs) system;
    imports = with inputs.self.homeModules; [
      { home.stateVersion = "25.05"; }

      core
      dev
      doom
      git
      ssh
      helix
      neovim
      shell
      terminal

      desktop
      hyprland
      niri
      waybar
      fuzzel

      {
        programs.git.extraConfig.user.signingkey = "~/.ssh/id_ed25519.pub";
        # "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr";
        programs.git.userName = "Lorenzo Giuliani";
        programs.git.userEmail = "lorenzo@frenzart.com";
      }
    ];
  };
}
