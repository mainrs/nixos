{ config, lib, namespace, osConfig ? {}, pkgs, ... }:

let 
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.cli-apps.zsh;
  cfg-dev = config.${namespace}.development;

  isSudoEnabled = lib.attrByPath ["security" "sudo" "enable"] false osConfig;
in {
  options.${namespace}.cli-apps.zsh = {
    enable = mkEnableOption "Enable the zsh module.";
    enableDefaultOhMyZshPlugins = mkEnableOption "Enable default Oh-my-zsh plugins, enhancing the shell experience.";
  };

  config = mkIf cfg.enable {   
    home.packages = lib.optional cfg.enableDefaultOhMyZshPlugins [
      pkgs.eza
      pkgs.fd
      pkgs.fzf
    ] ++ lib.optional cfg-dev.enable [
      pkgs.direnv
      pkgs.gh
      pkgs.git
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = enabled;
      syntaxHighlighting = enabled;

      oh-my-zsh = {
        enable = true;

        plugins = lib.optional isSudoEnabled [
          "sudo"
        ] ++ lib.optional cfg.enableDefaultOhMyZshPlugins [
          "eza"
          "fd"
          "fzf"
          "zoxide"
        ] ++ lib.optional cfg-dev.enable [
          # General development plugins.
          "bazel"
          "direnv"
          "dotenv"
          "extract"
          "gh"
          "git"
          "git-escape-magic"
        ] ++ lib.optional cfg-dev.android.enable [
          # Autocompletion for Android's `adb`.
          "adb"
          "gradle"
        ] ++ lib.optional cfg-dev.python.enable [
          "pip"
          "pipenv"
          "poetry"
          "poetry-env"
          "pylint"
          "python"
        ];
      };
    };

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

    ${namespace}.blacklist = [ pkgs.zsh ];
  };
}
