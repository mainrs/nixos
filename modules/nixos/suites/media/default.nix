{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.suites.media;
in {
  options.zt.suites.media = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable media configurations.";
  };

  config = mkIf cfg.enable {
    zt.apps = {
      vlc = enabled;
    };
  };
}
