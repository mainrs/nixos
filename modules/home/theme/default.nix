{ config, lib, namespace, ... }:

let 
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) mkOpt;

  flavorOption = lib.types.enum [
    "latte"
    "frappe"
    "macchiato"
    "mocha"
  ];
  accentOption = lib.types.enum [
    "blue"
    "flamingo"
    "green"
    "lavender"
    "maroon"
    "mauve"
    "peach"
    "pink"
    "red"
    "rosewater"
    "sapphire"
    "sky"
    "teal"
    "yellow"
  ];
  
  cfg = config.${namespace}.theme.catppuccin;
in {
  options.${namespace}.theme.catppuccin = {
    enable = mkEnableOption "catppuccin";
    accent = mkOpt accentOption "mauve" "Catppuccin accent color";
    flavor = mkOpt flavorOption "latte" "Catppuccin flavor";
  };

  config = mkIf cfg.enable {
    catppuccin.enable = true;
    catppuccin.accent = cfg.accent;
    catppuccin.flavor = cfg.flavor;
  };
}
