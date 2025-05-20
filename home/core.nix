{ ... }: { pkgs, ... }:
{
  home.packages = with pkgs; [
    htop
    ijq
    jq
    k9s
    lazygit
    lazysql
    nmap
    rage
    (ripgrep.override { withPCRE2 = true; })
    fd
    zstd
    xh
    pandoc
  ];

  home.sessionVariables = {
    # XDG_BROWSER = "elinks";
    VISUAL = "hx"; # NOTE: this is bad, but better than having to use `nano` or worse `pico`
    EDITOR = "hx";

    
  };

  programs.nix-index.enable = true;
}
