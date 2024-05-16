{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let 
  cfg = config.zt.apps.discord;
  discord = pkgs.discord.override {
    withOpenASAR = true;
  };
in {
  options.zt.apps.discord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
    firefox.enable = mkBoolOpt false "Whether or not to enable the Firefox version of Discord";
  };

  config = mkIf cfg.enable {
    zt.home.extraOptions = {
      home.packages = lib.optional cfg.enable discord ++ lib.optional cfg.firefox.enable pkgs.zt.discord-firefox;
    };
  };
}