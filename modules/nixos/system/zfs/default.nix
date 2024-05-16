{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.system.zfs;
in {
  options.zt.system.zfs = with types; {
    enable = mkBoolOpt false "Whether or not to enable the zfs service.";
    pools = mkOpt (listOf str) [ "rpool" ] "The ZFS pools to manage.";
  };

  config = mkIf cfg.enable {
    services.zfs = {
      autoScrub = {
        enable = true;
        pools = cfg.pools;
      };
    };
  };
}
