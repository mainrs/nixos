{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.archetypes.workstation;
in {
  options.zt.archetypes.workstation = with types; {
    enable = mkBoolOpt false "Whether to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    zt.suites = {
      common = enabled;
      desktop = enabled;
      media = enabled;
    };
  };
}
