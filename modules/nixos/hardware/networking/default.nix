{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.hardware.networking;
in {
  options.zt.hardware.networking = with types; {
    enable = mkBoolOpt false "Whether or not to enable networking support.";
    hosts = mkOpt types.attrs { }
      "An attribute set to merge with `networking.hosts`.";
  };

  config = mkIf cfg.enable {
    zt.user.extraGroups = [ "networkmanager" ];

    networking = {
      hosts = {
        "127.0.0.1" = [ "local.test" ] ++ (cfg.hosts."127.0.0.1" or [ ]);
      } // cfg.hosts;

      networkmanager = enabled;
    };
  };
}
