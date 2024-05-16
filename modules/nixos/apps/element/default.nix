{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;
let cfg = config.zt.apps.element;
in {
  options.zt.apps.element = with types; {
    enable = mkBoolOpt false "Whether or not to enable Element Desktop.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ element-desktop ];
  };
}
