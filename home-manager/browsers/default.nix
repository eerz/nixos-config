{
  pkgs,
  lib,
  config,
  userSettings,
  ...
}: let
  enableBrowsers =
    if (userSettings ? browsers) && builtins.isList userSettings.browsers && (builtins.length userSettings.browsers > 0)
    then true
    else false;
in {
  imports = [
    (./. + "/firefox")
  ];

  config.firefox =
    if enableBrowsers && builtins.elem "firefox" userSettings.browsers
    then {enable = true;}
    else {enable = false;};
}
