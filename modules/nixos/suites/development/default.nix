{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.suites.development;
in {
  options.zt.suites.development = with types; {
    enable = mkBoolOpt false "Whether or not to enable development configurations.";
  };

  config = mkIf cfg.enable {
    zt = {
      apps = {
        vscode = enabled;
        yubikey = enabled;
      };
    };
  };
}
