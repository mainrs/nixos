{ system, ...}:

{
  imports = [../me/default.nix];

  # `kyoto` is a CachyOS-based system, so we want to optimize the binaries for the platform.
  nixpkgs.config.hostPlatform = {
    gcc.arch = "alderlake";
    gcc.tune = "alderlake";
    system = system;
  };
}
