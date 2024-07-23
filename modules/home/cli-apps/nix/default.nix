{ config, lib, namespace, pkgs, ...}:

let 
  inherit (lib) mkOption mkIf types;

  cfg = config.${namespace}.cli-apps.nix;
in {
  options.${namespace}.cli-apps.nix = {
    enable = mkOption { default = true; type = types.bool; description = "nix"; };
  };

  config = mkIf cfg.enable {
    nix = {
      enable = true;
      package = pkgs.lix;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
