{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;

let cfg = config.zt.user;
in {
  options.zt.user = with types; {
    name = mkOpt str "me" "The name to use for the user account.";
    fullName = mkOpt str "mainrs" "The full name to use for the user account.";
    initialPassword =
      mkOpt str "password" "The initial password for the user account.";
    extraGroups =
      mkOpt (listOf str) [ ] "A list of groups for the user to be assigned to.";
    extraOptions =
      mkOpt attrs { } "A set of extra options passed to `users.users.<name>`.";
  };

  config = {
    # Configuring for the default shell I want to use.
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
    };

    zt.home = {
      extraOptions = {
        programs.starship = {
          enable = true;
          settings = {
            character = {
              success_symbol = "[➜](bold green)";
              error_symbol = "[✗](bold red) ";
              vicmd_symbol = "[](bold blue) ";
            };
          };
        };

        programs.zsh = {
          enable = true;
          enableAutosuggestions = true;
          syntaxHighlighting = enabled;
        };
      };
    };

    users.users.${cfg.name} = {
      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";
      shell = pkgs.zsh;

      extraGroups = cfg.extraGroups;

      # If false, user is treated as a system user. 
      isNormalUser = true;
    } // cfg.extraOptions;
  };
}
