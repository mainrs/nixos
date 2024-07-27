{ config, lib, namespace, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) disabled enabled;
  cfg = config.${namespace}.cli-apps.neovim;
in {
  options.${namespace}.cli-apps.neovim.enable = mkEnableOption "neovim";

  config = mkIf cfg.enable {
    programs.nixneovim = {
      enable = true;

      # Symlink vi/vim to neovim.
      viAlias = true;
      vimAlias = true;

      mappings = {
        # nvim-tree.
        normal."<leader>e" = {
          action = "'<cmd>NvimTreeFocus<CR>'";
        };
        normal."<C-n>" = {
          action = "'<cmd>NvimTreeToggle<CR>'";
        };

        # telescope.
        normal."<leader>ff" = {
          action = "'<cmd>Telescope find_files<CR>'";
        };
      };

      extraPlugins = [
        pkgs.vimExtraPlugins.cmp-nvim-lsp
        pkgs.vimExtraPlugins.cmp-buffer
        pkgs.vimExtraPlugins.cmp-path
        pkgs.vimExtraPlugins.cmp-cmdline
      ];

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

        # Basically everything required for autocompletion.
        nvim-cmp = {
          enable = true;
          snippet.luasnip.enable = true;

          sources = {
            buffer.enable = true;
            cmdline.enable = true;
            nvim_lsp.enable = true;
            path.enable = true;
          };
        };

        # File explorer.
        nvim-tree = {
          enable = true;

          # Disable built-in file explorer.
          disableNetrw = true;

          # Allows for hijacking the cursor when opening a file from the tree.
          hijackCursor = true;
          hijackNetrw = true;

          # The git integration is kind of slow most of the time. This is mostly noticeable when opening the file explorer.
          git = disabled;
        };

        # Fuzzy finding for files.
        telescope = {
          enable = true;
        };

        # Smart syntax highlighting, selection, indentation, etc.
        treesitter = {
          enable = true;
          indent = true;
        };
      };
    };

    # ${namespace}.blacklist = [ pkgs.neovim ];
  };
}
