{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.suites.desktop;
in {
  options.zt.suites.desktop = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    zt = {
      desktop = { gnome = enabled; };

      apps = {
        firefox = enabled;
        logseq = enabled;
        vlc = enabled;
      };
    };
  };
}
