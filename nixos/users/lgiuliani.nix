{ ... }:
{ ... }:
{
  home-manager.users.lgiuliani.programs.git.userName = "Lorenzo Giuliani";
  home-manager.users.lgiuliani.programs.git.userEmail =
    "lgiuliani@malwarebytes.com";
  home-manager.users.lgiuliani.programs.git.extraConfig.user.signingkey = "~/.ssh/id_ed25519.pub";
  # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII4awgnF6oRSD0DYJzY7+NWrbIUGTKG8DSk7ogtLEGOb";
  home-manager.users.lgiuliani.home.stateVersion = "25.05";
}
