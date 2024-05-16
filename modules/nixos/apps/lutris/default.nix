{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.apps.lutris;
in
{
  options.zt.apps.lutris = with types; {
    enable = mkBoolOpt false "Whether or not to enable Lutris.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lutris

      # Needed for some installers.
      openssl
      gnome.zenity
    ];
  };
}
