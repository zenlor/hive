# nix void spaceport

```
├───colmena: unknown
├───darwinConfigurations: unknown
├───devShells
│   ├───aarch64-darwin
│   │   └───default: development environment 'shell'
│   ├───aarch64-linux
│   │   └───default: development environment 'shell'
│   ├───x86_64-darwin
│   │   └───default: development environment 'shell'
│   └───x86_64-linux
│       └───default: development environment 'shell'
├───formatter
│   ├───aarch64-darwin: package 'nixpkgs-fmt-1.3.0'
│   ├───aarch64-linux: package 'nixpkgs-fmt-1.3.0'
│   ├───x86_64-darwin: package 'nixpkgs-fmt-1.3.0'
│   └───x86_64-linux: package 'nixpkgs-fmt-1.3.0'
├───homeConfigurations: unknown
├───homeModules: unknown
├───nixosConfigurations
│   ├───frenz: NixOS configuration
│   ├───horus: NixOS configuration
│   ├───nasferatu: NixOS configuration
│   └───pad: NixOS configuration
└───nixosModules
    ├───core: NixOS module
    ├───docker: NixOS module
    ├───gui: NixOS module
    ├───laptop: NixOS module
    ├───marrano-bot: NixOS module
    ├───network-manager: NixOS module
    ├───networking: NixOS module
    ├───openssh: NixOS module
    ├───secrets: NixOS module
    ├───torrent: NixOS module
    ├───users: NixOS module
    └───wsl: NixOS module
```

## Cheat sheet

- apply
  - locally: `colmena apply-local --node nixos-horus --sudo`
  - remote: `colmena apply -v --build-on-target --on nixos-nasferatu`
  - darwin: `nix run nix-darwin -- switch --flake .#macbook`
- `nix flake show` look at the outputs

### MacOS X idiosincracies

Alacritty doesn't want to pay the apple-fee, and they are right. Apple should
have, at least, a program for free software providing free, as in beer, signing
certificates.

Remove the quarantine: `xattr -rd com.apple.quarantine /Applications/Alacritty.app`

### No more `divnix/hive`?

As it stands the hive is simply over-shadowing most of the simplicity of nix
flakes, a good alternative is to use Haumea to load lazy derivations and include
them in the submodules, it's not as /clean/ but the tracebacks are greatly
simplified. Also ... it's now _much_ faster.

# URLs

- [/LnL7/nix-darwin](/LnL7/nix-darwin)
- [/nix-community/NixOS-WSL](/nix-community/NixOS-WSL)
- [/nix-community/haumea](/nix-community/haumea)
- [/nix-community/home-manager](/nix-community/home-manager)
- [/nix-community/nix-direnv](/nix-community/nix-direnv)
- [/zhaofengli/colmena](/zhaofengli/colmena)
- [/yaxitech/ragenix](/yaxitech/ragenix)
