{
  programs.ghostty = {
    enable = true;

    enableFishIntegration = true;
    installBatSyntax = true;

    settings = {
      theme = "Ayu Mirage";
      font-size = 12;
      keybind = [
        "ctrl+b>c=new_tab"

        "ctrl+b>[=previous_tab"
        "ctrl+b>]=next_tab"

        "ctrl+b>1=goto_tab:1"
        "ctrl+b>2=goto_tab:2"
        "ctrl+b>3=goto_tab:3"
        "ctrl+b>4=goto_tab:4"
        "ctrl+b>5=goto_tab:5"
        "ctrl+b>6=goto_tab:6"
        "ctrl+b>7=goto_tab:7"
        "ctrl+b>8=goto_tab:8"
      ];
    };
  };
}
