{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    discord.enable = lib.mkEnableOption "enables discord";
    discord.vesktop.enable = lib.mkEnableOption "enables discord along with vencord";
  };

  config = {
    # enable discord by default
    discord.enable = lib.mkDefault false;
    discord.vesktop.enable = lib.mkDefault true;

    # don't download discord if it's disabled
    home.packages = (with pkgs; [
      # downlaod discord only if it's enabled
      (lib.mkIf config.discord.enable discord)
      # download vesktop only if it's enabled
      (lib.mkIf config.discord.vesktop.enable vesktop)
    ]);

  };
}
