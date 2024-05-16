{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.tools.flake;
in {
  options.zt.tools.flake = with types; {
    enable = mkBoolOpt false "Whether or not to enable flake.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ snowfallorg.flake ]; };
}
