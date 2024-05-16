{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;
let cfg = config.zt.apps.vlc;
in {
  options.zt.apps.vlc = with types; {
    enable = mkBoolOpt false "Whether or not to enable VLC.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ vlc ]; };
}
