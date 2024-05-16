{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.tools.direnv;
in {
  options.zt.tools.direnv = with types; {
    enable = mkBoolOpt false "Whether or not to enable direnv.";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv = enabled;
    };
  };
}
