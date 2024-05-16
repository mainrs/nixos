{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;
let cfg = config.zt.apps.firefox;
in {
  options.zt.apps.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable Firefox.";
  };

  config = mkIf cfg.enable {
    # Install inside home-manager.
    zt.home.extraOptions = {
      programs.firefox = {
        enable = true;
        package = pkgs.firefox.override {
          cfg = {
            enableGnomeExtensions = config.zt.desktop.gnome.enable;
          };
        };
      };

    };

    # Make sure to enable browser connectors in case we have a matching desktop environment enabled.
    services.gnome.gnome-browser-connector.enable =
      config.zt.desktop.gnome.enable;
  };
}
