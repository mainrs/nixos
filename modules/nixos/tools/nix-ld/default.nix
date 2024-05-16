{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;
let cfg = config.zt.tools.nix-ld;
in {
  options.zt.tools.nix-ld = with types; {
    enable = mkBoolOpt false "Whether or not to enable nix-ld.";
  };

  config = mkIf cfg.enable { programs.nix-ld.enable = true; };
}
