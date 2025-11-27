{ inputs, ... }:
{
  system = "x86_64-linux";
  modules = with inputs.self.homeModules; [
    { home.stateVersion = "25.05"; }
    { home-manager.backupFileExtension = "backup"; }

    inputs.catppuccin.homeModules.catppuccin

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
      programs.git.settings.user.signingkey = "~/.ssh/id_ed25519.pub";
      # "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr";
      programs.git.settings.user.name = "Lorenzo Giuliani";
      programs.git.settings.user.email = "lorenzo@frenzart.com";
    }
  ];
}
