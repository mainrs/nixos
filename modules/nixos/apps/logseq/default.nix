{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;
let cfg = config.zt.apps.logseq;
in {
  options.zt.apps.logseq = with types; {
    enable = mkBoolOpt false "Whether or not to enable Logseq.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ logseq ]; };
}
