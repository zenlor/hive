{ ... }:
{ pkgs, ... }: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "ayu_dark";
      editor = {
        true-color = true; # force true color detection
        bufferline = "multiple";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        line-number = "relative";
        lsp.display-messages = true;
        lsp.display-inlay-hints =
          false; # extremely intrusive by default, but interesting
      };
      keys.normal = {
        space.space = "file_picker";
        space."." = "file_picker_in_current_buffer_directory";
        space.w = ":w";
        space.q = ":q";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };

    # languages.language = [
    #   {
    #     name = "hcl";
    #     file-types = [ "hcl" "nomad" ];
    #     language-servers = [ ];
    #     formatter = { command = "hclfmt"; };
    #   }
    #   {
    #     name = "tf";
    #     scope = "source.tfvars";
    #     file-types = [ "tfvars" "tf" ];
    #     language-servers = [ "terraform-ls" ];
    #     auto-format = true;
    #     grammar = "hcl";
    #     formatter = { command = "hclfmt"; };
    #   }
    #   {
    #     name = "nix";
    #     auto-format = true;
    #     formatter = { command = "${pkgs.nixfmt}/bin/nixfmt"; };
    #   }
    # ];
  };
}
