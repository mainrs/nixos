{ config, lib, namespace, pkgs, system, ...}:

let 
  inherit (lib) mkOption mkIf types;

  cfg = config.${namespace}.cli-apps.nix;
in {
  options.${namespace}.cli-apps.nix = {
    enable = mkOption { default = true; type = types.bool; description = "nix"; };
  };

  config = mkIf cfg.enable {
    nix.package = pkgs.lix; # FIXME: doesn't do anything right now...
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
