{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.zt.cli-apps.zsh;
in {
  options.zt.cli-apps.zsh.enable = mkEnableOption "Enable zsh.";

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      # Custom abbreviations.
      zsh-abbr.abbreviations = {
        code = "codium";

        # gh
        gcl = "gh repo clone";
        gw = "gh repo view -w";

        # git
        ga = "git add";
        gaa = "git add --all .";
        gb = "git branch";
        gbd = "git branch -D";
        gcm = "git checkout main";
        gco = "git checkout";
        gcob = "git checkout -b";
        gd = "git diff";
        gdc = "git diff --cached";
        gds = "git diff --staged";
        gl = "git log";
        gm = "git commit -m";
        gma = "git commit --amend";
        gman = "git commit --amend --no-edit";
        gp = "git push";
        gpf = "git push --force";
        gph = "git push origin HEAD";
        gphu = "git push origin HEAD -u";
        gpm = "git pull origin main";
        gpuh = "git push upstream HEAD";
        gpt = "git push --tags";
        gs = "git status";
      };

      # Enable oh-my-zsh, since it's easier to configure the terminal using it :)
      oh-my-zsh = {
        enable = true;
        plugins = [
          "colored-man-pages"
          "direnv"
          "dotenv"
          "extract"
          "history-substring-search"
          "zoxide"
          "zsh-abbr"
          "zsh-autosuggestions"
          "zsh-syntax-highlighting"
        ];
      };
    };
  };
}
