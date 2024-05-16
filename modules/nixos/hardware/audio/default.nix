{ config, lib, pkgs, options, ... }:

with lib;
with lib.zt;
let cfg = config.zt.hardware.audio;
in {
  options.zt.hardware.audio = with types; {
    enable = mkBoolOpt false "Whether or not to enable audio support.";
  };

  config = mkIf cfg.enable {
    # We need to disable NixOS's default audio server.
    hardware.pulseaudio.enable = mkForce false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };

    # Required by the PulseAudio server.
    security.rtkit = enabled;

    zt.user.extraGroups = [ "audio" ];
  };
}
