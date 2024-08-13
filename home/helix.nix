{
  programs.helix = {
    enable = true;

    settings = {
      theme = "base16_transparent";
      editor = {
        cursor-shape.insert = "bar";
        line-number = "relative";
        lsp.display-messages = true;
        lsp.display-inlay-hints = true;
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [ "collapse_selection" "keep_primary_selection" ];
        space.f = [
          ":new"
          ":insert-output lf -selection-path=/dev/stdout"
          "split_selection_on_newline"
          "goto_file"
          "goto_last_modification"
          "goto_last_modified_file"
          ":buffer-close!"
          ":redraw"
        ];
      };
    };
  };
}
