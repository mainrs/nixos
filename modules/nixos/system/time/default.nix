{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.system.time;
in {
  options.zt.system.time = with types; {
    enable =
      mkBoolOpt false "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable { time.timeZone = "Europe/Berlin"; };
}
