{
  inputs,
  pkgs,
  ...
}: {
  programs.dankMaterialShell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      withX11 = false;
      withCrashReporter = false;
    };

    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = false; # VPN management widget
    enableDynamicTheming = false; # Wallpaper-based theming (matugen)
    enableAudioWavelength = false; # Audio visualizer (cava)
    enableCalendarEvents = false; # Calendar integration (khal)

    niri = {
      enableKeybinds = false; # Automatic keybinding configuration
      enableSpawn = true; # Auto-start DMS with niri
    };
  };
}
