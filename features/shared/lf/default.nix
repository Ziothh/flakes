{
  user = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
      lf
    ] ++ lib.optionals stdenv.isLinux [
      ueberzug # Image preview in terminal — Linux/X11 only
    ];
    home.file = {
      ".config/lf/lfrc".source    = ./lfrc;
      ".config/lf/lfcd.sh".source = ./lfcd.sh;
      ".config/lf/cleaner".source = ./cleaner;
      ".config/lf/preview".source = ./preview;
    };
  };
}
