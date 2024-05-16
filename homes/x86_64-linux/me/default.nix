{ config, format ? "unknown", lib, pkgs, osConfig ? { }, ... }:
with lib.zt; {
  zt = {
    user = {
      enable = true;
      name = config.snowfallorg.user.name;
    };

    cli-apps = {
      home-manager = enabled;
      zsh = enabled;
    };

    tools = {
      comma = enabled;
      direnv = enabled;
      flake = enabled;
      nil = enabled;
    };
  };
}
