{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;
let cfg = config.zt.tools.comma;

in {
  options.zt.tools.comma = with types; {
    enable = mkBoolOpt false "Whether or not to enable comma.";
  };

  config = mkIf cfg.enable {
    # Enables `command-not-found` integrations.
    # programs.command-not-found.enable = mkForce false;
    programs.nix-index = enabled;

    # Enables `comma` and uses the `nix-index-database` to provide package information.
    programs.nix-index-database.comma.enable = true;
  };
}
