{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    discord.enable = lib.mkEnableOption "enables discord";
  };

  config = {
    # enable discord by default
    discord.enable = lib.mkDefault true;

    # don't download discord if it's disabled
    home.packages = lib.mkIf config.discord.enable (with pkgs; [
      discord
    ]);
  };
}
