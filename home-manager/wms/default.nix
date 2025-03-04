{userSettings, ...}: {
  imports = [
    (./. + "/hyprland")
  ];

  config.hyprland =
    if userSettings.wm == "hyprland"
    then {enable = true;}
    else {enable = false;};
}
