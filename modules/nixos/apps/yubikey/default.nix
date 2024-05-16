{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;
let cfg = config.zt.apps.yubikey;
in {
  options.zt.apps.yubikey = with types; {
    enable = mkBoolOpt false "Whether or not to enable Yubikey.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.yubikey-manager-qt ];
    services.yubikey-agent.enable = true;
  };
}
