{
  pkgs,
  lib,
  config,
  userSettings,
  ...
}: let
  enableSocials =
    if (userSettings ? socials) && builtins.isList userSettings.socials && (builtins.length userSettings.socials > 0)
    then true
    else false;
in {
  imports = [
    (./. + "/discord")
  ];

  config.discord =
    if enableSocials && builtins.elem "discord" userSettings.socials
    then {enable = true;}
    else {enable = false;};
}
