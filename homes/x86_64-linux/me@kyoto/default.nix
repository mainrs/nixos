{ lib, system, ...}:

with lib.zt;

{
  imports = [../me/default.nix];

  zt = {
    cli-apps = {
      neovim = enabled;
    };
    theme.catppuccin = enabled;
  };

  # `kyoto` is a CachyOS-based system, so we want to optimize the binaries for the platform.
  # FIXME: sadly, this does not work as I would have expected.
  nixpkgs.config = import ./nixpkgs-config.nix { inherit system; };
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
}
