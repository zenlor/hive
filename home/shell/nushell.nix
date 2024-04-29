{
  programs.nushell = {
    enable = true;
    configFile = ''
      let $config = {
        filesize_metric: false
        table_mode: rounded
        use_ls_colors: true
      }
    '';
  };
}
