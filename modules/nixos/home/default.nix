{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.home;
in {
  options.zt.home = with types; {
    configFile = mkOpt attrs { }
      "A set of files to be managed by home-manager's `xdg.configFile`.";
    extraOptions =
      mkOpt attrs { } "A set of options to be passed directly to home-manager.";
    file = mkOpt attrs { }
      "A set of files to be managed by home-manager's `home.file`.";
  };

  config = {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };

    # Configures the home-manager user section.
    snowfallorg.users.${config.zt.user.name}.home.config =
      config.zt.home.extraOptions;

    zt.home.extraOptions = {
      home.file = mkAliasDefinitions options.zt.home.file;
      home.stateVersion = config.system.stateVersion;

      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.zt.home.configFile;
    };
  };
}
