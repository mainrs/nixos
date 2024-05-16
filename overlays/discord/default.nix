{ channels, ... }:

final: prev: {
  # The normal discord package, using `unstable` to always keep it up-to-date.
  inherit (channels.unstable) discord;
  
  zt = (prev.zt or {}) // {
    discord-firefox = with prev; makeDesktopIcon {
      name = "Discord (Firefox)";
      desktopName = "Discord (Firefox)";
      genericName = "All-in-one cross-platform voice and text chat for gamers.";
      exec = ''
        ${firefox}/bin/firefox "https://discord.com/channels/@me?"
      '';
      icon = "discord";
      type = "Application";
      categories = ["Network" "InstantMessaging"];
      terminal = false;
      mimeTypes = ["x-scheme-handler/discord"];
    };
  };
}
