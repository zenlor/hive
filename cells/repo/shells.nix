{ inputs
, cell
}:
let
  # inherit (inputs)
  #   nixpkgs
  #   std
  #   std-data-collection
  #   ;
  # inherit (latest)
  #   nvfetcher
  #   cachix
  #   ;
  # inherit (inputs.std)
  #   lib
  #   ;

  l = inputs.nixpkgs.lib // builtins;

  latest = import inputs.nixpkgs-unstable {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };

  withCategory = category: attrset: attrset // { inherit category; };
in
l.mapAttrs (_: inputs.std.lib.dev.mkShell) {
  default = { ... }: {
    name = "Apis Mellifera";

    nixago = with inputs.std-data-collection.data.configs; [
      # treefmt
      # lefthook
      # editorconfig
      # (conform { data = { inherit (inputs) cells; }; })
    ];

    imports = [ ];

    commands = [
      (withCategory "hexagon" { package = inputs.nixpkgs.writedisk; })
      (withCategory "hexagon" { package = inputs.home-manager.packages.home-manager; })
      (withCategory "hexagon" { package = inputs.colmena.packages.colmena; })

      ## ragenix, secrets management
      (withCategory "hexagon" {
        package = inputs.ragenix.packages.ragenix;
      })
      (withCategory "hexagon" {
        name = "ragenix-rekey";
        help = "rekey secrets";
        command = ''
          ragenix --rules cells/nixos/secrets/secrets.nix --rekey
        '';
      })
      (withCategory "hexagon" {
        name = "ragenix-json";
        help = "check json output for secrets/secrets.nix";
        command = ''
          nix --extra-experimental-features nix-command eval -f cells/nixos/secrets/secrets.nix --json
        '';
      })

      # nixos-generate, iso creation
      (withCategory "hexagon" { package = inputs.nixos-generators.packages.nixos-generate; })
      (withCategory "hexagon" {
        name = "build-larva";
        help = "the hive x86_64-linux iso-bootstrapper";
        command = ''
          echo "Boostrap image is building ..."
          if path=$(nix build $PRJ_ROOT#nixosConfigurations.repo-o-larva.config.system.build.isoImage --print-out-paths); then
             echo "Boostrap image build finished."
             echo "-------"
             echo "You can now burn it to a USB with the following command:"
             echo -e "writedisk ./result/iso/$(echo $path | cut --delimiter '-' --output-delimiter '-' -f 2-)"
          else
             echo "Boostrap image build failed."
          fi
        '';
      })

      (withCategory "infra" {
        name = "update-cell-sources";
        help = "update cell package sources using nvfetcher";
        command = ''
          ${inputs.nvfetcher}/bin/nvfetcher -t \
            -o "cells/common/sources/" \
            -c "cells/common/sources/nvfetcher.toml" \
            $@
        '';
      })

      (withCategory "infra" {
        # TODO
        name = "update-secrets";
        help = "update ragenix secrets";
        command = ''
          echo ragenix rekey
        '';
      })
    ];
  };
}
