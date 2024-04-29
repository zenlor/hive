{
  programs.go = {
    enable = true;
    goPath = "lib";
  };

  programs.bun = {
    enable = true;
    enableGitIntegration = true;
    settings = {
      smol = true;
      telemetry = false;
    };
  };
}
