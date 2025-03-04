{
  description = "coco workspace";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    # ---- SYSTEM SETTINGS ---- #
    systemSettings = {
      system = "x86_64-linux"; # system arch
      hostname = "coco"; # hostname
      profile = "personal"; # select a profile defined from my profiles directory
      timezone = "Asia/Kolkata"; # select timezone
      locale = "en_IN"; # select locale
    };

    # ---- USER SETTINGS ---- #
    userSettings = {
      username = "bashgrl"; # username
      email = "bashgrls@gmail.com"; # emaile (used for certain configurations)
      browsers = ["firefox"];
      socials = ["discord"];
      editors = ["neovim"];
      wm = "hyprland";
    };

    lib = nixpkgs.lib;
    hlib = home-manager.lib;

    pkgs = nixpkgs.legacyPackages.${systemSettings.system};
  in {
    nixosConfigurations = {
      ${systemSettings.hostname} = lib.nixosSystem {
        system = systemSettings.system;
        modules = [(./. + "/hosts/home/configuration.nix")]; # load configuration.nix
        specialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };

    homeConfigurations = {
      ${userSettings.username} = hlib.homeManagerConfiguration {
        inherit pkgs;
        modules = [(./. + "/hosts/home/home.nix")]; # load home.nix
        extraSpecialArgs = {
          inherit userSettings;
        };
      };
    };
  };
}
