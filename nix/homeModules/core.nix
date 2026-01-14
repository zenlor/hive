{ pkgs, ... }:
{
  home.sessionVariables = {
    # vim as default editor
    EDITOR = "nvim";
    VISUAL = "hx";

    MANPAGER = "nvim +Man!";

    NNN_FIFO = "/run/user/1000/nnn.fifo";
  };

  home.shellAliases = {
  };

  home.packages = with pkgs; [
    fd
    entr
    ripgrep
    janet
  ];

  programs.nnn = {
    enable = true;
    plugins.src =
      (pkgs.fetchFromGitHub {
        owner = "jarun";
        repo = "nnn";
        rev = "v4.0";
        sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
      })
      + "/plugins";
    extraPackages =
      with pkgs;
      [
        ffmpegthumbnailer
        mediainfo
      ]
      ++ lib.optionals (!pkgs.stdenv.isDarwin) [
        # FIXME sxiv not supported under osx
        sxiv
      ];
    bookmarks = {
      d = "~/Documents";
      D = "~/Downloads";
      g = "~/Games";
      p = "~/Pictures";
    };
  };
}
