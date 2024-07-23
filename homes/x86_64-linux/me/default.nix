{ lib, namespace, ...}:

with lib.${namespace};

{
  zt = {
    cli-apps = {
      home-manager = enabled;
      nix = enabled;
      zsh = enabled;
    };
  };
}
