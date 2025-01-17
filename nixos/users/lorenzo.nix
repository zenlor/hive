{ root, stateVersion, ... }:
{ config, lib, pkgs, ... }:

{
  home-manager.users.lorenzo.programs.git.userName = "Lorenzo Giuliani";
  home-manager.users.lorenzo.programs.git.userEmail = "lorenzo@quantfi.tech";
  home-manager.users.lorenzo.programs.git.extraConfig.user.signingkey =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOGLWaOeeyPf8Pegp4q/PWCDFgtXoJ5dm4B4Gpw4SjwD";
}
