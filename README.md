# nix void spaceport

  * [ ] #php# Cheat sheet

- apply
  - locally: `sudo nixos-rebuild switch --flake .#<host>`
  - remote: `deploy --remote-build -s .#<host>`
  - darwin: `nix run nix-darwin -- switch --flake .#macbook`
- `nix flake show` look at the outputs

### MacOS X idiosincracies

Alacritty doesn't want to pay the apple-fee, and they are right. Apple should
have, at least, a program for free software providing free, as in beer, signing
certificates.

Remove the quarantine:
`xattr -rd com.apple.quarantine /Applications/Alacritty.app`

### No more `divnix/hive`?

As it stands the hive is simply over-shadowing most of the simplicity of nix
flakes, a good alternative is to use Haumea to load lazy derivations and include
them in the submodules, it's not as /clean/ but the tracebacks are greatly
simplified. Also ... it's now _much_ faster.

# URLs

- [/nix-community/flakelight](/nix-community/flakelight)
- [/LnL7/nix-darwin](/LnL7/nix-darwin)
- [/nix-community/NixOS-WSL](/nix-community/NixOS-WSL)
- [/nix-community/home-manager](/nix-community/home-manager)
- [/yaxitech/ragenix](/yaxitech/ragenix)
- [/yaxitech/ragenix](/ryantm/agenix)
- [serokell/deploy-rs](serokell/deploy-rs)
- [helix-editor/helix](helix-editor/helix)
