{
  programs.git = {
    enable = true;
    extraConfig = {
      push = { default = "current"; };
      pull = { rebase = true; };
    };
  };
}
