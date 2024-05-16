{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.system.fonts;
in {
  options.zt.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ font-manager ];

    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    fonts.packages = with pkgs;
      [
        (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
      ] ++ cfg.fonts;
  };
}
