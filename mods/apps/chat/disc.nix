{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    discord = {
      enable = lib.mkEnableOption "enables discord";
      vencord.enable = lib.mkEnableOption "enables discord along with vencord";
      asar.enable = lib.mkEnableOption "enables discord along with OpenASAR";
    };
  };

  config = {
    discord = {
      # enable discord by default
      enable = lib.mkDefault true;
      # enable vencord by default
      vencord.enable = lib.mkDefault true;
      # enable OpenASAR by default
      asar.enable = lib.mkDefault true;
    };

    # don't download discord if it's disabled
    home.packages = with pkgs; [
      # downlaod discord only if it's enabled
      (lib.mkIf config.discord.enable (discord.override {
        # only override with OpenASAR if it's enabled
        withOpenASAR = config.discord.OpenASAR.enable;
        # only override with vencord if it's enabled
        withVencord = config.discord.vencord.enable;
      }))
    ];
  };
}
