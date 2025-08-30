{ pkgs, ... }: {
  system.stateVersion = 5;

  nix.extraOptions = ''
    extra-experimental-features = flakes nix-command
  '';

  # Recreate /run/current-system symlink after boot
  # services.activate-system.enable = true;
  # active by default in nix-darwin-24.11

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

  # # https://github.com/LnL7/nix-darwin/issues/158#issuecomment-974598670
  # programs.zsh.enable = true;
  # programs.zsh.shellInit = ''export OLD_NIX_PATH="$NIX_PATH";'';
  # programs.zsh.interactiveShellInit = ''
  #   if [ -n "$OLD_NIX_PATH" ]; then
  #     if [ "$NIX_PATH" != "$OLD_NIX_PATH" ]; then
  #       NIX_PATH="$OLD_NIX_PATH"
  #     fi
  #     unset OLD_NIX_PATH
  #   fi
  #   if [ -d /opt/homebrew ]; then
  #     eval "$(/opt/homebrew/bin/brew shellenv)"
  #   fi
  # '';

  # https://github.com/nix-community/home-manager/issues/4026
  # fish shell setup
  programs.fish.enable = true;
  environment.shells = [ pkgs.zsh pkgs.fish ];
  users.users.lorenzo = {
    home = "/Users/lorenzo";
    shell = pkgs.fish;
  };
}
