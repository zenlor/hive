{
  lib,
  buildGoModule,
  fetchFromGitHub,
  buildNpmPackage,
}:
let
  version = "2.1.1";

  sha256 = "sha256-3+/VIdlOOSUooRg5pceXdMqZQe7rG1wBEINJOqkKBP4="; # sources
  npmDepsHash = "sha256-QpZUmr77tmLW6eGqL3emvoFDlrJiCebdpV8XN/a1u0o="; # npm/frontend
  vendorHash = "sha256-EpQoXojJJ4AyQnOUeU7wb6RoTansn/aBQ3Qkeqhjxbg="; # server vendor

  src = fetchFromGitHub {
    owner = "h44z";
    repo = "wg-portal";
    rev = "v${version}";
    inherit sha256;
  };

  frontend = buildNpmPackage {
    pname = "wg-portal-frontend";

    inherit version;
    inherit npmDepsHash;

    src = "${src}/frontend";
    npmBuildScript = "build";
    makeCacheWritable = true;
    # output folder
    DIST_OUT_DIR = "./dist";

    preBuild = ''
      # NOTE: sass-embedded is broken in NixOS. It fails at executing node_modules/sass-embedded-linux-x64/dart-sass/src/dart
      # embedding dynamically linked binaries is always bad for the environment and my pressure
      rm -r node_modules/sass-embedded*
    '';

    installPhase = ''
      runHook preInstall
      ls -la dist/
      mkdir -p $out
      cp -rv dist/* $out/
      runHook postInstall
    '';
  };
in
buildGoModule rec {
  pname = "wg-portal";
  inherit version;
  inherit src;

  ldflags = [
    "-s -w -X github.com/h44z/wg-portal/internal.Version=v${version}"
  ];

  inherit vendorHash;

  preBuild = ''
    mkdir -p ./internal/app/api/core/frontend-dist/
    cp -rv ${frontend}/* ./internal/app/api/core/frontend-dist/
  '';

  meta = with lib; {
    homepage = "https://github.com/h44z/wg-portal";
    description = "WireGuard Portal: a simple web-based confguration portal for WireGuard server management";
    platforms = platforms.linux;
  };
}
