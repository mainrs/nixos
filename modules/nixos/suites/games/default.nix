{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.suites.games;
in {
  options.zt.suites.games = with types; {
    enable = mkBoolOpt false "Whether or not to enable common game configurations.";
  };

  config = mkIf cfg.enable {
    zt = {
      apps = {
        doukutsu = enabled;
        lutris = enabled;
      };
    };
  };
}
