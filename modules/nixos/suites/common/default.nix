{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.suites.common;
in {
  options.zt.suites.common = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common common configuration.";
  };

  config = mkIf cfg.enable {
    zt = {
      hardware = {
        audio = enabled;
        networking = enabled;
      };

      services = { printing = enabled; };

      system = {
        boot = enabled;
        fonts = enabled;
        locale = enabled;
        time = enabled;
      };

      tools = { nix-ld = enabled; whats-in-my-store = enabled; };
    };
  };
}
