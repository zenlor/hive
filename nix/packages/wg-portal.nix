{ lib
, buildGoModule
, fetchFromGithub
,
}:
buildGoModule rec {
  pname = "wg-portal";
  version = "";

  src = fetchFromGithub {
    owner = "h44z";
    repo = "wg-portal";
    rev = "master"; # FIXME
    sha512 = "";
  };

  ldflags = [
    "-s -w -X github.com/h44z/wg-portal/version=${version}"
  ];

  meta = with lib; {
    homepage = "https://github.com/h44z/wg-portal";
    description = "WireGuard Portal: a simple web-based confguration portal for WireGuard server management";
    platforms = platforms.linux;
  };
}
