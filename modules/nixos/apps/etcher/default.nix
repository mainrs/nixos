{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;
let cfg = config.zt.apps.etcher;
in {
  options.zt.apps.etcher = {
    enable = mkEnableOption "Whether or not to enable the Etcher.";
  };

  config = mkIf cfg.enable { environment.systemPackages = [ pkgs.etcher ]; };
}
