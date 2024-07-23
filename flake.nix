{
  description = "My NixOS/Home-Manager configuration";

  inputs = {
    # We define two sets of inputs to make it possible to also install packages from unstable.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager.
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim configuration manager.
    nixneovim.url = "github:nixneovim/nixneovim";
    nixneovim.inputs.home-manager.follows = "home-manager";
    nixneovim.inputs.nixpkgs.follows = "nixpkgs";

    # Library that provides backwards compatibility with the old `nix-shell` interface.
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
    # Library that ties everything together.
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Useful tools for working with nix, flakes and more.
    flake.url = "github:snowfallorg/flake?ref=v1.4.1";
    flake.inputs.nixpkgs.follows = "unstable";
  };
  outputs = inputs: inputs.snowfall-lib.mkFlake {
    inherit inputs;

    src = ./.;

    alias = {
      shells.default = "configuration";
    };

    overlays = with inputs; [
      flake.overlays.default
      nixneovim.overlays.default
    ];

    # Modules added to all home-manager configurations.
    homes.modules = with inputs; [
      nixneovim.nixosModules.homeManager
    ];

    snowfall = {
      namespace = "zt";
    };
  };
}
