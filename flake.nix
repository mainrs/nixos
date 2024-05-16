{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = github:nix-community/NUR;

    # Some useful binaries and libraries from snowfallos.org. 
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    snowfall-lib.url = "github:snowfallorg/lib/dev";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";
    # snowfall-lib.inputs.flake-utils-plus.follows = "flake-utils-plus";
    snowfall-flake.url = "github:snowfallorg/flake?ref=v1.3.1";
    snowfall-flake.inputs.nixpkgs.follows = "unstable";
    # snowfall-flake.inputs.snowfall-lib.follows = "snowfall-lib";
    # snowfall-thaw.url = "github:snowfallorg/thaw?ref=v1.0.5";
    # snowfall-thaw.inputs.snowfall-lib.follows = "snowfall-lib";
    snowfall-wims.url = "github:snowfallorg/whats-in-my-store";
    snowfall-wims.inputs.nixpkgs.follows = "nixpkgs";

    # Library for project template generation that supports prompt questioning.
    copier.url = "github:copier-org/copier";

    # Hardware configuration.
    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    comma.url = "github:nix-community/comma";
    comma.inputs.nixpkgs.follows = "unstable";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    flake-checker.url = "github:DeterminateSystems/flake-checker";
    flake-checker.inputs.nixpkgs.follows = "nixpkgs";

    nil.url = "github:oxalica/nil";

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "unstable";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          meta = {
            name = "zerotask";
            title = "Zerotask";
          };

          namespace = "zt";
        };
      };
    in lib.mkFlake {
      channels-config = { allowUnfree = true; };

      overlays = with inputs; [
        copier.overlays.default
        nil.overlays.default
        snowfall-flake.overlays.default
        snowfall-wims.overlays.default
      ];

      # Register home-manager and NixOS modules.
      homes.modules = with inputs; [ nix-index-database.hmModules.nix-index ];
      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        nix-index-database.nixosModules.nix-index
        nix-ld.nixosModules.nix-ld
        nur.nixosModules.nur
      ];

      # Custom host configurations.
      systems.hosts.kyoto.modules = with inputs;
        [ nixos-hardware/nixosModules.framework-12th-gen-intel ];
    };
}
