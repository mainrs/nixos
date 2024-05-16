{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.system.boot;
in {
  options.zt.system.boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable booting.";
  };

  config = mkIf cfg.enable {
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 10;
  };
}
