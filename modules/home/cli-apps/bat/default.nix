{ config, lib, namespace, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;
  cfg = config.${namespace}.cli-apps.bat;
in {
  options.${namespace}.cli-apps.bat.enable = mkEnableOption "bat";

  config = mkIf cfg.enable {
    programs.bat = enabled;
  };
}
