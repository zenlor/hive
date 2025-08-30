{ pkgs, ... }: {
  system.stateVersion = 5;

  nix.extraOptions = ''
    extra-experimental-features = flakes nix-command
  '';

  nix = {
    enable = true;
    settings = {
      trusted-users = [ "@admin" "@staff" "lorenzo" ];
      system-features = [ "nixos-test" "apple-virt" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # build Linux NixOS under OSX
  nix.linux-builder = {
    enable = false;
    ephemeral = true;
    config = {
      nix.settings.sandbox = false;
      virtualisation = {
        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 8 * 1024;
        };
        cores = 6;
      };
    };
  };

  launchd.daemons.linux-builder = {
    serviceConfig = {
      StandardOutPath = "/var/log/darwin-builder.log";
      StandardErrorPath = "/var/log/darwin-builder.log";
    };
  };

  # enable touch id for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = "lorenzo";
  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    taps = [
      "homebrew/cask-versions"
      "homebrew/cask-fonts"
    ];
    brews = [
      "saml2aws"
      "ollama"
      "podman"
      "podman-compose"
      "awscli"
      "kubectl"
      "helm"
      "steampipe"
    ];
    casks = [
      "multipass"
      "utm"
      "wezterm"
      "launchcontrol"
      "keybase"
      "font-iosevka"
      "font-iosevka-aile"
      "font-iosevka-nerd-font"
      "jan"
      "wireshark"
      # This is ... .... so bad
      # also, as always, the aws cli crashes using a different boto3 version
      "session-manager-plugin"
    ];
  };

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  users.users.lorenzo = {
    home = "/Users/lorenzo";
    shell = pkgs.fish;
  };
}
