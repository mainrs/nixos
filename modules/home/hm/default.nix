{ lib, namespace, osConfig ? {}, ... }:

let
  inherit (lib) types;
  inherit (lib.${namespace}) mkOpt;
in {
  # A custom option for tracking what packages to _not_ install on a system. Mainly used for CachyOS.
  options.${namespace}.blacklist = mkOpt (types.listOf types.package) [] "A list of packages to *not* install";

  config = {
    home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "24.05"); 
  };
}
