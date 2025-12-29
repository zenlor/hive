{ pkgs, ... }:
let
  MB = 1000000;
  # GB = MB * 1000;
in
{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
    download-buffer-size = 500 * MB;
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

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

  system.activationScripts = {
    # Print a summary of nixos-rebuild changes
    diff = {
      supportsDryActivation = true;
      text = ''
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
          /run/current-system "$systemConfig"
      '';
    };
  };

  environment.systemPackages = with pkgs; [
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
    btop
    jq
    ncdu
    nnn
    ripgrep
    tmux
    xh
    janet
    nil
    nvd
    trippy
    lsof

    zstd
    zip
    unzip
    p7zip
    p7zip-rar
    unrar
  ];

  ##
  # Users
  ##
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = true;
    users.lor = {
      isNormalUser = true;
      description = "Lorenzo";
      extraGroups = [
        "bluetooth"
        "input"
        "networkmanager"
        "wheel"
      ];
      uid = 1000;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO4vpKL4UUOAm9g92tn+Ez6c+zPum4dxm7ocVlyGDskC0/lKa/i+fG/hzzWH3TLvolhyCvzByswGj/eXDnEURaY5yfjd65i7EQGz7GSZb8XCS1/nG7/zdxantsw4a8YdnSDKzCgNWfveXYwmxT9mJi+3jcUbvkL6qTZy9r+Pm+ovmzEwOQex8tx+OCJyfaoD3VjrzWqIW6o16vua5akgs2BnFOMhLkLutf4MoB20ZuXV6RN8A7XoCcQiqxMV68p7z2ACKuXQyuh/UkJARSRKTURLbF00YF9NVh3FNSXOj9m5Nhh8d4P1dGvI1xXZjYF7+YYt4y/dpYS6GIpr3zzkFh lorenzo@frenz"
      ];
      # hashedPasswordFile = lib.mkDefault config.age.secrets.lor-password.path;
    };
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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [
      "en_GB.UTF-8/UTF-8"
      "it_IT.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  # Binary cache
  nix.settings.substituters = [
    "https://attic.xuyh0120.win/lantian"
    "https://cache.garnix.io"
  ];
  nix.settings.trusted-public-keys = [
    "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  ];
}
