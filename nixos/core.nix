{ super, inputs, ... }:
{ pkgs, lib, ... }:
let GB = 1024 * 1024 * 1024;
in {
  # Selection of sysadmin tools that can come in handy
  environment.systemPackages = with pkgs; [

    # hardware
    usbutils
    pciutils
    psutils

    # general purpose rograms
    curl
    direnv
    dnsutils
    entr
    fd
    file
    git
    gnused
    iftop
    jq
    lnav
    lsd
    lsof
    ncdu
    neovim
    nmap
    nnn
    ripgrep
    tmux
    whois
    xh
    zenith
    zig

    # manpages, you never know when they are useful
    man-pages
    man-pages-posix
  ];

  documentation.dev.enable = true;
  documentation.man = {
    generateCaches = true;
    man-db.enable = false;
    mandoc.enable = true;
  };

  environment.shellAliases = {
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
    top = "zenith";

    mkdir = "mkdir -pv";
    cp = "cp -iv";
    mv = "mv -iv";

    ll = "ls -l";
    la = "ls -la";

    path = ''printf \"%b\\n\" \"\''${PATH//:/\\\n}\"'';
    tm = "tmux new-session -A -s main";

    issh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
  };

  environment.pathsToLink = [ "/share/zsh" ];

  environment.variables = {
    # vim as default editor
    EDITOR = "nvim";
    VISUAL = "nvim";

    # Use custom `less` colors for `man` pages.
    LESS_TERMCAP_md = "$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)";
    LESS_TERMCAP_me = "$(tput sgr0 2> /dev/null)";

    # Don't clear the screen after quitting a `man` page.
    MANPAGER = "less -X";
  };

  nix.settings.sandbox = true;

  # Give root user and wheel group special Nix privileges.
  nix.settings.trusted-users = [ "root" "@wheel" ];

  nix.settings.keep-outputs = true;
  nix.settings.keep-derivations = true;
  nix.settings.builders-use-substitutes = true;
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  nix.settings.fallback = true;
  nix.settings.warn-dirty = false;

  # Some free space
  nix.settings.min-free = lib.mkDefault (5 * GB);

  # Improve nix store disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # cachix
  nix.settings.extra-trusted-substituters = [
    "https://cache.garnix.io"
    "https://cachix.org/api/v1/cache/emacs"
    "https://colmena.cachix.org"
    "https://hyprland.cachix.org"
    "https://microvm.cachix.org"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://nichijou.cachix.org"
    "https://nix-community.cachix.org"
    "https://nixos-cn.cachix.org"
    "https://nixpkgs-wayland.cachix.org"
    "https://numtide.cachix.org"
  ];
  nix.settings.extra-trusted-public-keys = [
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
    "nichijou.cachix.org-1:rbaTU9nLgVW9BK/HSV41vsag6A7/A/caBpcX+cR/6Ps="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
    "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
  ];

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
    };
  };

  # shells
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
  };

  programs.fish = {
    enable = true;
    useBabelfish = lib.mkDefault false;
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
  };

  users.defaultUserShell = pkgs.zsh;

  # Editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
