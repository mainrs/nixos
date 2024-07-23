{ config, lib, namespace, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;
  cfg = config.${namespace}.cli-apps.neovim;
in {
  options.${namespace}.cli-apps.neovim.enable = mkEnableOption "neovim";

  config = mkIf cfg.enable {
    programs.nixneovim = {
      enable = true;

      # Symlink vi/vim to neovim.
      viAlias = true;
      vimAlias = true;

      plugins = {
        # Language server protocol (LSP). Used for autocompletion, linting, etc.
        lspconfig = {
          enable = true;
          servers = {
            # Bash: https://www.gnu.org/software/bash/
            bashls = enabled;

            # Nix: https://nixos.org
            nil = enabled;

            # Rust: https://rust-lang.org
            rust-analyzer = enabled;
          };
        };

        # Smart syntax highlighting, selection, indentation, etc.
        treesitter = {
          enable = true;
          indent = true;
        };
      };
    };
  };
}
