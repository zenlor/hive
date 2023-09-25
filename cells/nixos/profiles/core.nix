{ inputs, ... }:
let
  inherit (inputs.nixpkgs)
    self
    config
    lib
    pkgs
    ;
  inherit (lib)
    fileContents
    ;
  inherit (pkgs.stdenv.hostPlatform)
    isDarwin
    ;
in
{
  system.stateVersion = "23.05";

  imports = [
    inputs.ragenix.nixosModules.default
  ];

  environment = {
    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      binutils
      coreutils
      curl
      direnv
      delta
      bat
      thefuck
      dnsutils
      fd
      git
      bottom
      jq
      nmap
      ripgrep
      tmux
      whois
      zsh
      fish
      neovim
      file
      gnused
      lsof
      lnav
      lsd
      iftop
      ncdu
      xh
    ];

    shellAliases =
      let
        # The `security.sudo.enable` option does not exist on darwin because
        # sudo is always available.
        ifSudo = lib.mkIf (isDarwin || config.security.sudo.enable);
      in
      {
        # quick cd
        ".." = "cd ..";
        "..." = "cd ../..";
        "cd.." = "cd ..";

        "vim" = "nvim";

        # internet ip
        # TODO: explain this hard-coded IP address
        myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

        mn = ''
          manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | sk --preview="manix '{}'" | xargs manix
        '';
        top = "btm";

        mkdir = "mkdir -pv";
        cp = "cp -iv";
        mv = "mv -iv";

        ll = "ls -l";
        la = "ls -la";

        path = "printf \\\"%b\\\\n\\\" \\\"\\\${PATH//:/\\\\\\n}\\\"";
        tm = "tmux new-session -A -s main";

        issh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
      };

    pathsToLink = [ "/share/zsh" ];

    variables = {
      # vim as default editor
      EDITOR = "nvim";
      VISUAL = "nvim";

      # Use custom `less` colors for `man` pages.
      LESS_TERMCAP_md = "$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)";
      LESS_TERMCAP_me = "$(tput sgr0 2> /dev/null)";

      # Don't clear the screen after quitting a `man` page.
      MANPAGER = "less -X";
    };
  };

  nix = {
    settings =
      let
        GB = 1024 * 1024 * 1024;
      in
      {
        # Prevents impurities in builds
        sandbox = true;

        # Give root user and wheel group special Nix privileges.
        trusted-users = [ "root" "@wheel" ];

        keep-outputs = true;
        keep-derivations = true;
        builders-use-substitutes = true;
        experimental-features = [ "flakes" "nix-command" ];
        fallback = true;
        warn-dirty = false;

        # Some free space
        min-free = lib.mkDefault (5 * GB);
      };

    # Improve nix store disk usage
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    nixPath = [
      "nixpkgs=flake:nixos"
      "home-manager=flake:home"
    ];

    registry =
      let
        inputs' = lib.filterAttrs (n: _: !(builtins.elem n [ "cells" "self" "nixpkgs" ])) inputs;
      in
      lib.mapAttrs (_: v: { flake = v; }) inputs';
  };

  # shells
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # motd
  programs.rust-motd = {
    enable = true;
    enableMotdInSSHD = true;
    settings = {
      global = {
        progress_full_character = "=";
        progress_empty_character = "-";
        progress_prefix = "[";
        progress_suffix = "]";
      };
      uptime.prefix = "up";
      filesystems.root = "/";
      fail_2_ban.jails = [ "sshd" ];
    };
  };
}
