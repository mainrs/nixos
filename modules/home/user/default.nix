{ config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.zt;

let
  cfg = config.zt.user;

  home-directory = if cfg.name == null then null else "/home/${cfg.name}";
in {
  options.zt.user = {
    enable = mkEnableOption "Whether to configure a user account.";
    name = mkOpt (types.nullOr types.str) (config.snowfallorg.user.name or "me")
      "The name of the user account.";

    fullName = mkOpt types.str "mainrs" "The full name of the user account.";
    email = mkOpt types.str "" "The email address of the user account.";

    home = mkOpt (types.nullOr types.str) home-directory
      "The home directory of the user account.";
  };

  config = mkIf cfg.enable (mkMerge [{
    assertions = [
      {
        assertion = cfg.name != null;
        message = "zt.user.name must be set.";
      }
      {
        assertion = cfg.home != null;
        message = "zt.user.home must be set.";
      }
    ];

    home = {
      username = mkDefault cfg.name;
      homeDirectory = mkDefault cfg.home;
    };
  }]);
}
