{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.tools.nil;
in {
  options.zt.tools.nil = with types; {
    enable = mkBoolOpt false "Whether or not to enable nil.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ nil ]; };
}
