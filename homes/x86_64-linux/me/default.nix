{ lib, namespace, ...}:

with lib.${namespace};

{
  zt = {
    cli-apps = {
      home-manager = enabled;
      flake = enabled;
      nix = enabled;
      zsh = enabled;
    };
  };
}
