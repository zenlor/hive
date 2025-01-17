{ ... }: {
  programs.git.extraConfig.user.signingkey =
    "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr";
  programs.git.userName = "Lorenzo Giuliani";
  programs.git.userEmail = "lorenzo@frenzart.com";
}
