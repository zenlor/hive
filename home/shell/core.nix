{
  home.shellAliases = {
    # quick cd
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";

    # emacs
    e = "emacsclient -n";

    # nix
    n = "nix";
    nepl = "nix repl '<nixpkgs>'";
    nr = "nix run";
    nd = "nix develop";
    ns = "nix shell";
    np = "nix profile";
    npl = "nix profile list";
    npi = "nix profile install";
    npr = "nix profile remove";
    npu = "nix profile upgrade";
    npua = "nix profile upgrade '.*'";
    nf = "nix flake";
    nfu = "nix flake update";
    nfck = "nix flake check";

    # sudo
    s = "sudo -E ";
    si = "sudo -i";
    se = "sudoedit";

    # systemd
    ctl = "systemctl";
    stl = "sudo systemctl";
    sup = "sudo systemctl start";
    sdn = "sudo systemctl stop";
    utl = "systemctl --user";
    uup = "systemctl --user start";
    udn = "systemctl --user stop";
    jtl = "journalctl";

    # ls
    l = "ls";

    # tmux utf
    tmux = "tmux -u";

    # vim shall be neo
    vim = "nvim";
  };

  home.sessionPath = [ "$HOME/.local/bin" "$HOME/lib/bin" "$HOME/.rd/bin" ];
}
