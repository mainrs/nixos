{ system }:

{
  hostPlatform = {
    gcc.arch = "alderlake";
    gcc.tune = "alderlake";
    system = system;
  };
}
