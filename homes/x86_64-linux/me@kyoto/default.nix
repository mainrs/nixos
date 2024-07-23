{ system, ...}:

{
  imports = [../me/default.nix];

  # `kyoto` is a CachyOS-based system, so we want to optimize the binaries for the platform.
  # FIXME: sadly, this does not work as I would have expected.
  nixpkgs.config = import ./nixpkgs-config.nix { inherit system; };
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
}
