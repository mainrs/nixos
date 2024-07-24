{ lib, namespace, pkgs, ...}:

let 
  inherit (lib.${namespace}) dummyPackage enabled;

  packages-to-not-install = with pkgs; [
    alacritty
  ];
  programs-that-override-package-attr = map (pkg: {
    name = "${pkg.pname}";
    package = dummyPackage pkgs;
  }) packages-to-not-install or [];
in {
  zt = {
    cli-apps = {
      home-manager = enabled;
      flake = enabled;
      nix = enabled;
      zsh = enabled;
    };
  };

  # Overwrite some packages to ensure that the CachyOS version is installed.
  programs = builtins.foldl' (acc: override:
    lib.attrsets.recursiveUpdate acc { ${override.name}.package = override.package; }
  ) {} programs-that-override-package-attr;
}
