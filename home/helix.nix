{
  programs.helix = {
    enable = true;

    settings = {
      theme = "base16_transparent";
      editor = {
        cursor-shape.insert = "bar";
        line-number = "relative";
        lsp.display-messages = true;
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };
  };
}
