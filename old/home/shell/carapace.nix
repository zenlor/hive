{
  # https://github.com/rsteube/carapace-bin
  programs.carapace = {
    enable = true;

    enableBashIntegration = false; # don't care about bash
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
}
