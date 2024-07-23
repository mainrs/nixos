{lib, inputs, namespace, pkgs, mkShell, ...}:

mkShell {
  packages = with pkgs; [
    nixd
    nixfmt
    snowfallorg.flake
  ];
}
