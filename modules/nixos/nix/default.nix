{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;
let cfg = config.zt.nix;
in {
  options.zt.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nixUnstable "Which package to use.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      deploy-rs
      flake-checker
      nixfmt
      nix-index
      nix-prefetch-git
      nix-output-monitor
    ];

    # We need to disable the `command-not-found` hook because it's not compatible with `nix-index`.
    programs.command-not-found.enable = false;

    nix = let
      user = config.zt.user.name;
      users = [ "root" user ] ++ optional config.services.hydra.enable "hydra";
      isHomeManagerDirenvEnabled =
        config.home-manager.users.${user}.zt.tools.direnv.enable;
    in {
      package = cfg.package;

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      settings = {
        experimental-features = "nix-command flakes";
        http-connections = 50;
        warn-dirty = false;
        auto-optimise-store = true;

        allowed-users = users;
        trusted-users = users;
      } // (optionalAttrs isHomeManagerDirenvEnabled {
        keep-derivations = true;
        keep-outputs = true;
      });

      # flake-utils-plus
      generateNixPathFromInputs = true;
      generateRegistryFromInputs = true;
      linkInputs = true;
    };
  };
}
