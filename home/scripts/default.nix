{
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    dataFile = {
      "lib/bin/colors" = ./colors;
      "lib/bin/git-summarise-history" = ./git-summarise-history;
    };
  };
}
