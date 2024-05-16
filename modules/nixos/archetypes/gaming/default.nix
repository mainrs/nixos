{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.archetypes.gaming;
in {
  options.zt.archetypes.gaming = with types; {
    enable = mkBoolOpt false "Whether to enable the gaming archetype.";
  };

  config = mkIf cfg.enable {
    zt.suites = {
      common = enabled;
      desktop = enabled;
      games = enabled;
      media = enabled;
    };
  };
}
