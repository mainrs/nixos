{ config, lib, namespace, pkgs, ...}:

let 
  inherit (lib.${namespace}) mkSimpleDummyPackage enabled;
  dummyPackage = mkSimpleDummyPackage pkgs;
in
{
  zt = {
    cli-apps = {
      bat = enabled;
      home-manager = enabled;
      flake = enabled;
      nix = enabled;
      zsh = enabled;
    };

    gui = {
      alacritty = enabled;
    };
  };

  # Overwrite some packages to ensure that the CachyOS version is installed.
  programs = builtins.foldl' (acc: override:
    lib.attrsets.recursiveUpdate acc { ${override.pname}.package = dummyPackage; }
  ) {} config.${namespace}.blacklist;
}
