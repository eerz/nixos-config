{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    firefox.enable = lib.mkEnableOption "enables firefox";
  };

  config = {
    # enable firefox by default
    firefox.enable = lib.mkDefault true;

    # don't download firefox if it's disabled
    home.packages = lib.mkIf config.firefox.enable (with pkgs; [
      firefox
    ]);
  };
}
