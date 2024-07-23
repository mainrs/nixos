{lib, inputs, namespace, pkgs, mkShell, ...}:

mkShell {
  packages = with pkgs; [
    git
    nixd
    nixfmt
    snowfallorg.flake
  ];
}
