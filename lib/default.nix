{ lib, ... }:

{
  disabled = {
    enable = false;
  };

  enabled = {
    enable = true;
  };

  mkOpt =
    type: default: description:
    lib.mkOption { inherit type default description; };
  
  mkSimpleDummyPackage = pkgs: pkgs.runCommand "dummy" {} ''
    mkdir -p $out/bin
    touch $out/bin/dummy
  '';
}
