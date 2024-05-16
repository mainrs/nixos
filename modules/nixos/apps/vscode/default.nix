{ config, lib, pkgs, options, unstable, ... }:

with lib;
with lib.zt;

let cfg = config.zt.apps.vscode;
in {
  options.zt.apps.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable Vscodium.";
  };

  config = mkIf cfg.enable {
    # Install inside home-manager.
    zt.home.extraOptions = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;

        # Since we update our program and extensions using `nix`.
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions = with unstable.vscode-extensions; [
          # Linters.
          timonwong.shellcheck

          # Tailwindcss autocompletion.
          bradlc.vscode-tailwindcss

          # UI improvements.
          aaron-bond.better-comments
          eamodio.gitlens
          johnpapa.vscode-peacock
          usernamehw.errorlens
        ];
      };
    };
  };
}
