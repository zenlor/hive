{ config, pkgs, ... }: {

  nix.extraOptions = ''
    extra-experimental-features = flakes nix-command
  '';

  # Recreate /run/current-system symlink after boot
  services.activate-system.enable = true;

  services.nix-daemon.enable = true;

  nix = {
    nixPath = [
      # TODO: This entry should be added automatically via FUP's
      # `nix.linkInputs` and `nix.generateNixPathFromInputs` options, but
      # currently that doesn't work because nix-darwin doesn't export packages,
      # which FUP expects.
      #
      # This entry should be removed once the upstream issues are fixed.
      #
      # https://github.com/LnL7/nix-darwin/issues/277
      # https://github.com/gytis-ivaskevicius/flake-utils-plus/issues/107
      "darwin=/etc/nix/inputs/darwin"
    ];

    settings = {
      # Administrative users on Darwin are part of this group.
      trusted-users = [ "@admin" "@staff" ];
    };

    configureBuildUsers = true;
  };

  # enable touch id for sudo
  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    taps = [ "homebrew/cask-versions" "homebrew/cask-fonts" ];
    brews = [
      "saml2aws"
      "ollama"
    ];
    casks = [
      "utm"
      "wezterm"
      "launchcontrol"
      "keybase"
      "font-437-plus"
      "font-iosevka"
      "font-iosevka-aile"
      "font-iosevka-nerd-font"
      "jan"
    ];
  };

  fonts.fontDir.enable = true;

  # https://github.com/LnL7/nix-darwin/issues/158#issuecomment-974598670
  programs.zsh.enable = true;
  programs.zsh.shellInit = ''export OLD_NIX_PATH="$NIX_PATH";'';
  programs.zsh.interactiveShellInit = ''
    if [ -n "$OLD_NIX_PATH" ]; then
      if [ "$NIX_PATH" != "$OLD_NIX_PATH" ]; then
        NIX_PATH="$OLD_NIX_PATH"
      fi
      unset OLD_NIX_PATH
    fi
  '';

  # https://github.com/nix-community/home-manager/issues/4026
  # fish shell setup
  programs.fish.enable = true;
  environment.shells = [
    pkgs.zsh
    pkgs.fish
  ];
  users.users.lorenzo = {
    home = "/Users/lorenzo";
    shell = pkgs.fish;
  };
}
