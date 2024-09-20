{ ... }:
{ pkgs, ... }: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "base16_transparent";
      editor = {
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
        space.w = ":w";
        space.q = ":q";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };
    languages.language = [
      {
        name = "hcl";
        file-types = [ "hcl" "tfvars" ];
        auto-format = true;
        formatter.command = "${pkgs.hclfmt}/bin/hclfmt";
        language-servers = [ ];
      }
      {
        name = "terraform";
        scope = "source.terraform";
        file-types = [ "tf" ];
        auto-format = true;
        formatter.command = "${pkgs.hclfmt}/bin/hclfmt";
        language-servers = [ "terraform-ls" ];
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }
    ];
  };
}
