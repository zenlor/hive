{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    colors = {
      bg = "#1e1e1e";
      "bg+" = "#1e1e1e";
      fg = "#d4d4d4";
      "fg+" = "#d4d4d4";
    };

    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'head {}'" ];
    changeDirWidgetCommand = "fd --type d";

    tmux = {
      enableShellIntegration = true;
      shellIntegrationOptions = [ "-d 35%" ];
    };
  };
}
