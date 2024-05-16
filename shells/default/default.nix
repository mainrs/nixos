{ lib, pkgs, ... }:

pkgs.mkShell { packages = with pkgs; [ nixfmt snowfallorg.flake ]; }
