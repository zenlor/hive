{ ... }:
{ pkgs, ... }: {
  programs.helix = {
    enable = true;

    languages = {
      language = [
        {
          name = "hcl";
          file-types = [ "hcl" "tfvars" "nomad" ];
          language-servers = [ ];
          formatter = { command = "hclfmt"; };
        }
        {
          name = "tfvars";
          scope = "source.tfvars";
          file-types = [ "tf" ];
          formatter = { command = "hclfmt"; };
          language-servers = [ "terraform-ls" ];
          comment-token = "#";
        }
      ];
    };

    settings = {
      theme = "tokyonight";
      editor = {
        true-color = true; # force true color detection
        bufferline = "multiple";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        line-number = "absolute";
        cursorline = true;
        text-width = 80;
        color-modes = true;
        popup-border = "popup";
        lsp = {
          display-messages = true;
          display-inlay-hints = true; # extremely intrusive by default, but interesting
        };
        indent-guides = {
          render = true;
          character = "┆";
        };
        smart-tab = {
          enable = true;
          supersede-menu = true;
        };
        # FIXME: added in version 25.01
        # inline-diagnostics = {
        #   cursor-line = "warning";
        #   prefix-len = 3;
        #   other-lines = "error";
        # };
      };
      keys.normal = {
        space.space = "file_picker";
        space."." = "file_picker_in_current_buffer_directory";
        space.w = ":w";
        space.q = ":q";
        esc = [ "collapse_selection" "keep_primary_selection" ];
        C-g = [
          ":write-all"
          ":new"
          ":insert-output lazygit"
          # First disable mouse to hint helix into activating it
          ":set mouse false"
          ":set mouse true"
          ":buffer-close!"
          ":redraw"
          ":reload-all"
        ];
      };

      # smart-tab
      keys.normal.tab = "move_parent_node_end";
      keys.normal.S-tab = "move_parent_node_start";
      keys.insert.S-tab = "move_parent_node_start";
      keys.select.tab = "extend_parent_node_end";
      keys.select.S-tab = "extend_parent_node_start";
    };
  };
}
