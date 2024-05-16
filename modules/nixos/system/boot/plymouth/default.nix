{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.system.boot.plymouth;
in {
  options.zt.system.boot.plymouth = with types; {
    enable = mkBoolOpt false "Whether or not to enable Plymouth.";
    theme = mkOpt 
  };

  config = mkIf cfg.enable {
    boot.initrd.systemd.enable = true;
    boot.plymouth = {
      enable = true;
      theme = if cfg.theme == null then "bgrt" else cfg.theme.name;
      themePackages = mkIf (cfg.theme != null) [ pkgs.zt.framework-plymouth-theme ];
    };

    # This is required to have no output before the Plymouth boot screen.
    boot.kernelParams = [ "quiet" ];
  };
}
