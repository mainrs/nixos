{ config, lib, namespace, pkgs, ... }:

let 
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.cli-apps.flake;
in {
  options.${namespace}.cli-apps.flake.enable = mkEnableOption "flake";

  config = mkIf cfg.enable {
    home.packages = [pkgs.snowfallorg.flake];
  };
}
