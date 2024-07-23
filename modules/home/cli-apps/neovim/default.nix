{ config, lib, namespace, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.cli-apps.neovim;
in {
  options.${namespace}.cli-apps.neovim.enable = mkEnableOption "neovim";

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      
      # Symlink vi/vim to neovim.
      viAlias = true;
      vimAlias = true;
    };
  };
}
