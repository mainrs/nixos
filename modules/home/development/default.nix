{ lib, namespace, ... }:

let
  inherit (lib) mkEnableOption;
in {
  options.${namespace}.development = {
    enable = mkEnableOption "Enable the development module.";

    android = {
      enable = mkEnableOption "Enable the Android development module.";
    };
    python = {
      enable = mkEnableOption "Enable the Python development module.";
    };
    rust = {
      enable = mkEnableOption "Enable the Rust development module.";
    };
  };
}
