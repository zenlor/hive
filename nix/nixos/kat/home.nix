{ inputs, config, ... }:
{
  home-manager.backupFileExtension = "backup";
  home-manager.users.lor = {
    imports =
      with inputs.self.homeModules;
      let
        homeDirectory = config.users.users.lor.home;
      in
      [
        { home.stateVersion = "25.11"; }
        { home.homeDirectory = homeDirectory; }

        inputs.stylix.homeModules.stylix

        core
        dev
        doom
        git
        ssh
        helix
        neovim
        shell
        terminal

        hyprland
        niri
        waybar
        fuzzel

        theme

        {
          programs.git.settings.user.signingkey = "${homeDirectory}/.ssh/id_ed25519.pub";
          # "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr";
          programs.git.settings.user.name = "Lorenzo Giuliani";
          programs.git.settings.user.email = "lorenzo@frenzart.com";
        }
      ];
  };
}
