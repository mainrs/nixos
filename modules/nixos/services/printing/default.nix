{ config, pkgs, lib, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.services.printing;
in {
  options.zt.services.printing = with types; {
    enable = mkBoolOpt false "Whether or not to configure printing support.";
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
    zt.user.extraGroups = [ "lp" ];
  };
}
