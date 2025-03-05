{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wallpaper = lib.mkOption {
      default = ../../../wall/menhera.jpg;
      type = lib.types.path;
      description = ''
        Path to your wallpaper
      '';
    };
  };

  config = {
    home.packages = with pkgs; [
      swww
    ];

    home.file."testscript.sh".source = let
      script = pkgs.writeShellScriptBin "testscript.sh" ''
        ${pkgs.swww}/bin/swww img ${config.wallpaper}
      '';
    in "${script}/bin/testscript.sh";
  };
}
