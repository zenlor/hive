{ inputs, ... }: {
  system = "x86_64-linux";
  modules = with inputs.self.homeModules; [
    { home.stateVersion = "25.05"; }
    { home-manager.backupFileExtension = "backup"; }
    
    core
    dev
    doom
    git
    ssh
    helix
    neovim
    shell
    terminal

    # WM
    desktop
    # hyprland
  ];
}
