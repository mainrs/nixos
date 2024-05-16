{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.system.locale;
in {
  options.zt.system.locale = with types; {
    enable = mkBoolOpt false "Whether or not to configure locale information.";
  };

  config = mkIf cfg.enable {
    console.keyMap = mkForce "us";
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
