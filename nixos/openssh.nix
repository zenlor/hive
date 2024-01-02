{
  services.openssh = {
    enable = true;

    settings = {
      X11Forwarding = false;
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      UseDns = false;

      # Use key exchange algorithms recommended by `nixpkgs#ssh-audit`
      KexAlgorithms = [
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group16-sha512"
        "diffie-hellman-group18-sha512"
        "sntrup761x25519-sha512@openssh.com"
      ];
    };

    # unbind gnupg sockets if they exists
    extraConfig = "StreamLocalBindUnlink yes";
  };

  # A list of well known public keys
  # Avoid TOFU MITM with github by providing their public key here.
  programs.ssh.knownHosts = {
    "github.com".hostNames = [ "github.com" ];
    "github.com".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

    "gitlab.com".hostNames = [ "gitlab.com" ];
    "gitlab.com".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";

    "git.sr.ht".hostNames = [ "git.sr.ht" ];
    "git.sr.ht".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60";
  };

  services.sshguard = {
    enable = true;
    services = [ "sshd" ];
    blacklist_threshold = 120;
    attack_threshold = 60;
    whitelist = [
      "10.69.0.1"
      "10.69.0.2"
      "10.69.0.3"
      "10.69.0.4"
      "10.69.0.5"
      "192.168.1.2"
      "192.168.1.136"
    ];
  };
}
