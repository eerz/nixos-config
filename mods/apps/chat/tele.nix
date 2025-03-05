{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    telegram.enable = lib.mkEnableOption "enables telegrams";
  };

  config = {
    # enable telegram by default
    telegram.enable = lib.mkDefault true;

    # don't download telegram if it's disabled
    home.packages = lib.mkIf config.telegram.enable (with pkgs; [
      telegram-desktop
    ]);
  };
}
