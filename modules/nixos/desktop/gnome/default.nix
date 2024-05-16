{ config, lib, pkgs, ... }:

with lib;
with lib.zt;
let cfg = config.zt.desktop.gnome;
in {
  options.zt.desktop.gnome = {
    enable = mkBoolOpt false "Whether to enable the GNOME desktop environment.";
    color-scheme =
      mkOpt (types.enum [ "light" "dark" ]) "light" "The color scheme to use.";
    extensions = mkOpt (types.listOf types.package) [ ]
      "Extra GNOME shell extensions to install.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [ gnome.gnome-tweaks ] ++ cfg.extensions;

    # GSConnect.
    programs.kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };

    # Even though the name is a little bit confusing, this does indeed enable GNOME with wayland support.
    services.xserver = {
      enable = true;
      libinput = enabled;
      displayManager.gdm = enabled;
      desktopManager.gnome = enabled;
    };

    # # Almost all of the GNOME customization is done per-user. Thus, we leverage home-manager to do our bidding.
    # zt.home.extraOptions = {
    #   dconf.settings = {
    #     nested-default-attrs = {
    #       "/org/gnome/desktop/interface" = {
    #         color-scheme = if cfg.color-scheme == "light" then "default" else "prefer-dark";
    #         enable-hot-corners = false;
    #       };
    #     };
    #   };
    # };
  };
}
