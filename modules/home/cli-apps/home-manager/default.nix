{ config, lib, ... }:

with lib;
with lib.zt;
let cfg = config.zt.cli-apps.home-manager;
in {
  options.zt.cli-apps.home-manager.enable =
    mkEnableOption "Enable home-manager and its extras.";

  config = mkIf cfg.enable { programs.home-manager = enabled; };
}
