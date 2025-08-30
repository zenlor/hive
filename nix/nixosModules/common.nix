{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.ragenix.nixosModules.default
  ];

  ##
  # Environment
  ##
  security = {
    protectKernelImage = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  environment.shellAliases = {
    myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";
    top = "htop";

    ll = "ls -l";
    la = "ls -la";

    tm = "tmux new-session -A -s main";
  };

  environment.variables = {
    # vim as default editor
    EDITOR = "nvim";
    VISUAL = "hx";

    MANPAGER = "nvim +Man!";
  };

  environment.systemPackages = with pkgs;[
    usbutils
    pciutils
    psutils

    curl
    dnsutils
    entr
    fd
    fzf
    file
    git
    gnused
    htop
    btm
    jq
    ncdu
    nnn
    ripgrep
    tmux
    xh
    janet

    zstd
    zip
    unzip
    p7zip
    p7zip-rar
  ];
  
  ##
  # Users
  ##
  users.defaultUserShell = pkgs.fish;
  users.mutableUsers = true;
  users.users.lor = {
    isNormalUser = true;
    description = "Lorenzo";
    extraGroups = ["wheel" "networkmanager" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO4vpKL4UUOAm9g92tn+Ez6c+zPum4dxm7ocVlyGDskC0/lKa/i+fG/hzzWH3TLvolhyCvzByswGj/eXDnEURaY5yfjd65i7EQGz7GSZb8XCS1/nG7/zdxantsw4a8YdnSDKzCgNWfveXYwmxT9mJi+3jcUbvkL6qTZy9r+Pm+ovmzEwOQex8tx+OCJyfaoD3VjrzWqIW6o16vua5akgs2BnFOMhLkLutf4MoB20ZuXV6RN8A7XoCcQiqxMV68p7z2ACKuXQyuh/UkJARSRKTURLbF00YF9NVh3FNSXOj9m5Nhh8d4P1dGvI1xXZjYF7+YYt4y/dpYS6GIpr3zzkFh lorenzo@frenz"
    ];
    hashedPasswordFile = lib.mkDefault config.age.secrets.lor-password.path;
  };

  ##
  # Secrets
  ##
  age.identityPaths = [
    "/home/lor/.ssh/id_ed25519"
    "/home/lor/.ssh/id_rsa"
  ];

  age.secrets.lor-password.file = ../../secrets/users/lor.age;
  age.secrets.root-password.file = ../../secrets/users/root.age;

  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
  };
  virtualisation.oci-containers.backend = "podman";

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

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;
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
      "82.169.232.124"
    ];
  };


  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "it_IT.UTF-8";
      LC_IDENTIFICATION = "it_IT.UTF-8";
      LC_MEASUREMENT = "it_IT.UTF-8";
      LC_MONETARY = "it_IT.UTF-8";
      LC_NAME = "it_IT.UTF-8";
      LC_NUMERIC = "it_IT.UTF-8";
      LC_PAPER = "it_IT.UTF-8";
      LC_TELEPHONE = "it_IT.UTF-8";
      LC_TIME = "it_IT.UTF-8";
    };
  };
}
