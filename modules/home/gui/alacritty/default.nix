{ config, lib, namespace, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;
  cfg = config.${namespace}.gui.alacritty;
in {
  options.${namespace}.gui.alacritty.enable = mkEnableOption "alacritty";

  config = mkIf cfg.enable {
    programs.alacritty = enabled;

    ${namespace}.blacklist = [ pkgs.alacritty ];
  };
}
