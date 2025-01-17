{ ... }: {
  programs.git.extraConfig.user.signingkey =
    "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOGLWaOeeyPf8Pegp4q/PWCDFgtXoJ5dm4B4Gpw4SjwD";
  programs.git.userName = "Lorenzo Giuliani";
  programs.git.userEmail = "lorenzo@quantfi.tech";
}

