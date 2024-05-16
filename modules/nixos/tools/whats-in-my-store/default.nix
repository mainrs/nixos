{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.tools.whats-in-my-store;
in {
  options.zt.tools.whats-in-my-store = with types; {
    enable = mkBoolOpt false "Whether or not to enable whats-in-my-store.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.snowfallorg.whats-in-my-store ];
  };
}
