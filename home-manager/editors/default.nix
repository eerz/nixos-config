{userSettings, ...}: let
  enableEditors =
    if (userSettings ? editors) && builtins.isList userSettings.editors && (builtins.length userSettings.editors > 0)
    then true
    else false;
in {
  imports = [
    (./. + "/neovim")
  ];

  config.neovim =
    if enableEditors && builtins.elem "neovim" userSettings.editors
    then {enable = true;}
    else {enable = false;};
}
